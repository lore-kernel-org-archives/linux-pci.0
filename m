Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD12DEA74;
	Tue, 21 Jul 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659979; cv=none; b=TT6JWvqFX3FmB6fP56dtM73cx8MQ2f3C92TYU3b8uU80HONMiTNN4OSdqgWh/jCWhKNmg99IP5Nl6cvj+3TWS1erpCR2hvJoqBy88+TBRwEE/tUhtkm0VmD1ff9QKo+RAoO6YhMe3qyfEyNz5vaYEi74Ln64QCQ3zv++S1wy/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659979; c=relaxed/simple;
	bh=IfszOsyUj4Skr5PEi/x3RweO6tHgepG7yTpFj7PEpLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9vXGtfeJnQjjjygbHVzUlPZexw33WJoClHK2GsDCYDNmnxwwy9ksgZBAdOKHq1EX4MvUfV6pYNwJJ2Pqur2tcV7oYKQ0W3xzLdT/5Tymjz1ikXsW6nEb49wvcTpbN3aO7ZszqAI02WeergKmgsXnNtEVRsLoT54HatFKYA5tbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUFu4piH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUFu4piH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798051F00ACA;
	Tue, 21 Jul 2026 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659978;
	bh=NN1+I3Y2Ia7vFPUpLF0faQvhg99ndfxvEeeB0XKXwdQ=;
	h=From:To:Cc:Subject:Date;
	b=MUFu4piHhUppkUXntiQYT6Fkobom+bPK7ctPPgNlmGV6RwghhCwpBxkgQU93ghRd6
	 K0GZljyCUehHMKI0o4laqm7BoZ9GDp5pdaGp5OxZHjbXApb9PVqiDP3UNy0EvTEKtM
	 yzBBIee22Eyyngf+lxofSq1FQwSk92yz+PZE4dFMYvGybQueunqGTD1JCicppKf0v5
	 hM57UYv41pUR2In7TdxvLNO7+q1oDTdcJM8mJ/WDaM0pxgG0GXo5nfC+MKW0etfm9u
	 7/qkZcW0PNvtN28vraAz28i2z7j1108o4i3upWDO2JFBPTs5FqvPeVtCbA66QnSFqE
	 ysnu69f2QxRcA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Dan Williams <djbw@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev
Subject: [PATCH 0/2] mm,kernfs: Fix stale userspace mappings after sysfs file removal
Date: Tue, 21 Jul 2026 18:52:50 +0000
Message-ID: <20260721185252.1670958-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

PCI resource sysfs files swap their f_mapping to iomem_get_mapping() at
open time so that revoke_iomem() can hole-punch userspace mappings when
a driver claims the BAR (636b21b50152, "PCI: Revoke mappings like
devmem").  Their VMAs therefore live on the shared iomem address_space,
which kernfs_drain_open_files() does not walk, unmapping the sysfs
inode's own i_mapping instead.  Userspace thus keeps live mappings of
PCI BARs across device removal and resizable-BAR resize, with stale
PTEs into physical address space the kernel may have reassigned.

After the device is removed, a read from a resource0 mapping returns
the previous register value instead of faulting.

The first patch adds unmap_mapping_file(), which zaps VMAs selected by
the originating struct file rather than by address space window, with
a stub for !CONFIG_MMU builds.  The second uses it in the kernfs
drain for files with a swapped f_mapping, keeping the existing
unmap_mapping_range() path for everything else.

Before 636b21b50152 these VMAs were attached to the sysfs inode and the
drain did zap them, so this restores the earlier teardown semantics
while keeping the driver-claim revocation intact.  Files without an
f_mapping swap (p2pdma, cgroup, everything else) see no change.  The
same access now raises SIGBUS.

BAR resize is covered by the same path, since resize removes the
resource groups.  /dev/mem and /proc/bus/pci mappings of the same
BAR are unaffected.

Krzysztof Wilczyński (2):
  mm: Add unmap_mapping_file() helper
  kernfs: Unmap mmaps of removed files via file->f_mapping

 fs/kernfs/file.c   |  5 ++++-
 include/linux/mm.h |  2 ++
 mm/memory.c        | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.55.0

