Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC7341650
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997291; cv=none; b=ejUDegiY2m6jwc1i4bc6Ijos0/UoODuRkls5+/kB5tE857kYiK01zxHrrt5Ztbr5mWDR0WEvGOA1ytjtYzU9grXmG6nj+PRXoWVWTeg2hHu5wYVstcylePcE010bnRoy3K/dDe4pyEX0ma+4Y5GKcxVX9EWu27K3EpeND+8SMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997291; c=relaxed/simple;
	bh=l9tqnFzFrSjN8cXxumhwXJEJ078VRqZiI4KHy0mccoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx3ECZ8JhxOIjiA6nVxwItbfBViIHjjW4UjcS4FhEAW1PmG9yWqjPqT6DL+ip+9QwmGDtZMOLIadLuS0YwJs60mIT57trTjXhsT0klmFObtUoo2NFv93hnRBvzoPMFQb86sIwwUS2GfP3UmS0E2bRekJhKCuRVt2dr9wKIFuVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2HHUwXU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2HHUwXU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso273804a91.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997289; x=1788602089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC0I9ujd++ODGJE/sqEk3NvSSAuaZ1MshchVq7tKt20=;
        b=E2HHUwXUzOOEuH4jge23rKbOvEj3NkiBJSrjK2KkiRC8m2Oph52BG6qNUi3S/3Rjpq
         PdnNVuozclVabXc6Pm2xva8UH41XAovWTbYPbbWvPXFMYbdlfhA3lH/0eLoRwLWzH3dP
         PrcFO3w7LqFtOxn+zSES1LBX8OCGnxQULVnyr6GkI7I6Kzts6BixNWuLHMgzNm06L9Rc
         SasOEwzf6CMb7474fg8a/r+5eZRYV7MZOaNW34UlSqwsc6pebq1EJhEHI301v0UOK7Yq
         N9dvERzwzPpqbWt3a94zrE3SnGvF6kQlYI2vDefiollttAaALtPVYXRdAv6Pclc5QXLw
         iOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997289; x=1788602089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oC0I9ujd++ODGJE/sqEk3NvSSAuaZ1MshchVq7tKt20=;
        b=RdWXFqnw3glukIgqj7XwKu803/Fj7pgTFK+tcBLopyxUsSdgrl5K59SJMtYqCCDHUU
         8m7n8BPO9upTzrxRTHaysPD3AaDJpVn3lX8yk54VJ7Gnis81YurUbElRfsgmZb4AgBSb
         atHi9u9JkGRmN7A6W+QQaLfXw+X3PAj31rCFUGMAq0DYcN4d3AaSiSuMgRl1QkD7k9HS
         WoBAdq4/A+vB9I8Z8RuaHfDrWlPpY/KPMPwU1IPwI/HB8olLFZQGsEcqnFnG0Cqd9L9B
         PPbQ8aAT7sgrrkeTD+YegRWSeqs4j463I5N8xey2nj/j853tsW1uCI73uSxHVbQzgLrx
         BntQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKzljo59Fuk9PMc6ciqOXHyPcPsdbB+PxIA/e1Py5u3frct/ZNR7Aw2yL9axC/G+sJV00d3qDrvwQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nBaJ4ivGl9i5XoK7NskY04gZ8V+Sy8lFXujDev/Rthn5OHtkBR
	RzH77st4S2ipBq2AnOHNl8Z0ymYUjQnKIk1mKR4qyAWQ2XsNmJTAKq94
X-Gm-Gg: AYBFou1cutTe+1vuyRAkheoy87RYdyPdmUmkWPWHDw8qankM/ZYsxns4oIu890uOpmA
	55YgLI/MhhAGfzG8q9wMNb4zJv4Xt21qPVUxSHRjYycHOADETikRLDUP+6hPp4vXQskZMJ7v/OJ
	oOFU2nk8AKKy5BVO6OhGpKbsVsvSpTU9VPaBDd9qb6K9wjxh/lcqt2KzLgYYzxVYjuFomHz4wRI
	4gTDtdMrv4wnKoJ2mTGIO7yFoCkl2uxbb4XNL00So081PUi3qR2UYRW0DNEYEcaFuQuqY/7D5AL
	2z9epa+jVU5YvHGom105JehGf0WQbTCf8bdwduUgz7YCUz3TLS+eqh/C1rsvO62mR+QsVPJ61Sc
	uXkQ8ICz7m9LiihPhhTeL3fMfNtBISl8vj8SwB5OLPLhTQxbNEYuIWGxpGt62s5I7J6K/Xd1IS2
	Lj+/6kqQSInt67gl9b2dbhVeTdziTEcRhSZLRFfxdIoJMj4sPO3uvROqJxbIe/22VM/AKJkj+DS
	NTM7Fr51aEgCWpQDew/TLao3A+qBvANKw==
X-Received: by 2002:a17:90b:5543:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-398bab83160mr1221956a91.3.1787997288891;
        Sat, 29 Aug 2026 02:54:48 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:3104:d691:c7eb:3b03:2c8d:127f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm15775697eec.6.2026.08.29.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:54:48 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: nika@nikableh.moe,
	emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	markpearson@lenovo.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>
Subject: [PATCH wireless 0/2] wifi: iwlwifi: recover the device after it loses power in D3cold
Date: Sat, 29 Aug 2026 15:24:35 +0530
Message-ID: <20260829095437.44716-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On several Meteor Lake laptops the Intel BE200 does not survive a D3cold
transition: the platform's _PR3 power resource genuinely removes the M.2
module's rail, and the card does not restart when the rail and PERST# are
restored. Config space reads 0xffffffff, the link never trains, and the
device stays gone until a reboot.

iwlwifi already has everything needed to recover it. The platform-level
device reset walks _PRR and evaluates _RST, and the vendor _DSM that arms
it is already spoken. The problem is ordering: arming happens from the
removal path, by which point the device no longer answers, and the _DSM is
gated on the firmware reading the device's PCI ID back out of config
space. So arming can never succeed at the one moment it matters.

Patch 1 arms it at probe, while the device still answers. Patch 2 asks for
a product reset when the device is not on the bus after resume, instead of
re-initialising hardware that is not there.

Analysis, register dumps and the discussion this came out of:
Link: https://lore.kernel.org/all/20260829093922.37103-1-navonjohnlukose@gmail.com/

Tested on a Lenovo Yoga Pro 7 14IAH10 (BIOS QGCN35WW), BE200
SUBSYS_00F48086: the card dies in D3cold on every s2idle exactly as
before, and recovers on its own in about 5s, repeatedly, with wifi both
connected and idle at suspend time. With the reset skipped but everything
else identical it stays absent, so the reset is what recovers it rather
than the remove/rescan.

Caveats: one machine and one BIOS, discrete (!integrated) path only - I
have no CNVi hardware, so the integrated arming mask is untested.
Recovery costs ~4.3s of Sleep() inside the platform's _RST, which is
firmware and not something we can shorten.

Tagged for stable: the PLDR path has never worked on platforms with this
_DSM gate, and both changes are small and self-limiting - every _RST
evaluation is already preceded by set_product_reset() setting the mode
that reset wants, so arming at probe cannot alter the behaviour of any
later reset.

Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Navon John Lukose (2):
  wifi: iwlwifi: pcie: arm the product reset at probe
  wifi: iwlwifi: pcie: request a product reset when the device is gone
    after resume

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  5 +++++
 2 files changed, 17 insertions(+)
