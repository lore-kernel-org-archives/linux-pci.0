Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430B3E2AC8
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691131; cv=none; b=OCjsEp7QMgUWRhpYOmIr0H7RmQfeiCoQirH/nse0YwvnlO3QVaZJ3k4IM6iKesEDp0KXA72JUw1SlXc5jHFD0RQ/1+Oan23/Q7dQ6UMxFqlulM15h+3ib4B6aoz/jffGKDHu2MVMPxv1plU/X5g0w6mzlsqV4YzGEGahm364+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691131; c=relaxed/simple;
	bh=37fSWFvCptx+2VIOWFlTB6FmJliZe3rnLm89zHFsUqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQZlhZBuGidM8LK0V0MCb15O8QIQnwh2izVN+qweYBfkRBMwi5XBAvokQIKypO0pJn3I2HiHxnumqRyEGiDKoDyX7sN9Gq00R39LlbD78My4YO7vO8jSA5+I6AikPFZALoF8hylwWg2jIFFbBkPHeW8x0bZwuomE3Lm1BAAhNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if9+JBBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if9+JBBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F001F000E9;
	Fri, 14 Aug 2026 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691125;
	bh=gBJMvCAxjK47LPVL+Fm+GL+zh8cfP+tBcYDlVGPsMtw=;
	h=From:To:Cc:Subject:Date;
	b=if9+JBBm90aMJiieutFHm6+0gx8QWhWDAbX14jYy32SFDSAaf0i7R/Kq3wkGdjDT+
	 1ZLAdbmA5HIWUEQcDvTOhlsRzVxTFtBad5Wu7ZkmG8XQd/AituWc0PeTYqpUhRouI5
	 N0A5Ve4fE8XM87YAizkIqtM2xEi5LRx+q+AgVH14ZC+bFcnXceszifC+sci/rO0A9p
	 3aHOenCwuTq3kYHmxrlul5O8rM0nvLwwUzUYQq0p62F0kEiXJfdegLSxIOLHtLdAiL
	 Tx21xVV3a57dwJ57DQ7LdkpDvjHVWKYDizuyVxcqGWDsQqumJj6he4/KVRfvdp4ZHi
	 vR/zEaEz7mlxQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@Dell.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/4] PCI/sysfs: Fix the ACPI device name attributes
Date: Fri, 14 Aug 2026 07:05:18 +0000
Message-ID: <20260814070522.2327975-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the "label" and "acpi_index" attributes are created whenever
the _DSM function 0 bitmap advertises the Device Name function, and
dsm_get_label() returns the literal -1 on every failure path.  Firmware
that advertises the function but returns an object that cannot be
parsed therefore produces two attributes that exist and fail every read
with -EPERM:

  $ cat /sys/bus/pci/devices/0000:00:08.3/label
  cat: /sys/bus/pci/devices/0000:00:08.3/label: Operation not permitted

Nothing in that path performs a permission check.  Tools that read the
attribute print the failure on every invocation, which is how this
surfaced in a pciutils report:

  https://github.com/pciutils/pciutils/issues/175

Patch 1 returns error codes that describe what failed.  Patch 2 stops a
malformed optional device name element from also failing "acpi_index",
which exports the mandatory instance number and does not depend on the
name.  Patch 3 evaluates the function when deciding visibility, so that
an attribute exists only when the element it exports has a type the read
path accepts.  The documented ABI already describes the behaviour patch
3 implements, and the SMBIOS attribute group in the same file already
works that way.

Patch 4 corrects the length dsm_label_utf16s_to_utf8s() passes to
utf16s_to_utf8s().  The ACPI buffer length counts bytes, while the
converter counts wchar_t elements.  For a buffer holding no NUL code
unit the conversion reads past the end of the object allocated by
ACPICA.  The bytes it finds there are decoded into the world readable
"label" attribute.

Note that patch 2 changes behaviour on platforms that have a valid
instance number together with a malformed name element: "acpi_index"
starts returning data there.  Because udev derives the onboard
interface name from "acpi_index", an interface on such a platform may
be renamed once, on the first boot after this change.  The same
mechanism, in the other direction, is recorded in dcfa9be83866 ("ACPI /
PCI: Fix sysfs acpi_index and label errors").

No ACPI dump accompanies the report, so the object that platform returns
is not known.  The malformed results tested below are constructed.

Tested under QEMU with an SSDT that overrides _DSM on the ACPI companion
of a PCI device.  Function 0 advertises the Device Name function, and
function 7 returns a chosen object.  Nine cases, on the series and on
v7.2-rc1, with CONFIG_KASAN=y:

  Function 7 returns                        label       acpi_index
  ----------------------------------------  ----------  ----------
  Package(2){1, "TESTLABEL"}                TESTLABEL   1
  Package(2){1, ""}                         empty       1
  Package(2){1, Buffer{"BUF", terminated}}  BUF         1
  Package(2){1, Buffer{NUL}}                empty       1
  Package(2){0, 0}                          absent      0
  Package(2){"BAD", "NAME"}                 absent      absent
  Package(2){1, Buffer(0x40)} unterminated  32 chars    1
  valid twice, then an integer              -EIO        -EIO
  QEMU acpi-index=7                         empty       7

On v7.2-rc1 the first four and the last behave identically, so
compliant firmware is unaffected, including the generator QEMU uses for
stable interface names.  Package(2){0, 0} reproduces the reported
failure there, with both attributes returning -EPERM.

For patch 4, the unterminated buffer case on v7.2-rc1 leaked two bytes
of adjacent memory into the attribute, and under KASAN:

  BUG: KASAN: slab-out-of-bounds in utf16s_to_utf8s+0x21f/0x250
  Read of size 2 at addr ffff88800e77b088 by task cat/109
  ...
  allocated 136-byte region [ffff88800e77b000, ffff88800e77b088)
  ...
  acpi_ut_initialize_buffer+0xc7/0x190
  acpi_evaluate_object+0x694/0x920
  acpi_evaluate_dsm+0x16e/0x230
  dsm_get_label.isra.0+0x6b/0x300

With the series applied the same case reads correctly and KASAN stays
silent.  The two terminated buffer cases produce no splat before or
after.  Reaching the read needs the missing terminator, not the buffer
form as such.

Krzysztof Wilczyński (4):
  PCI/sysfs: Stop reporting _DSM failures as -EPERM
  PCI/sysfs: Decouple acpi_index from the optional device name element
  PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
  PCI/sysfs: Pass the device name length in UTF-16 code units

 Documentation/ABI/testing/sysfs-bus-pci | 14 ++--
 drivers/pci/pci-label.c                 | 94 ++++++++++++++++++-------
 2 files changed, 79 insertions(+), 29 deletions(-)

-- 
2.55.0

