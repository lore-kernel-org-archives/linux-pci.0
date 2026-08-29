Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57942357D0E
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997298; cv=none; b=MYdo24QNE0Yd5OO2Xy6mDFEUPO2UdgQhHvE9rKR2hz6WvhTRaa7M+1ArYFyXL/qjhN+KpsDAYjC9d8Id6mVAorvA1j0dgKlzH0usq8HXhftp0b51flALyKh1ihsGT9xQEYSwYKKI7ITmwVCYveG5TX2BtOJTOj6PjTmQtgViw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997298; c=relaxed/simple;
	bh=7hM5WaRrHs2c3LW1CjwRnik2dDd+6Q2n4lB4uydT71o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCP24EBwu7nCztdts1rAtfoOwqrfBq03bNMMe72iRMph7kclRUexaHv4ESomUN1y5QeQ5FFeimw62rlw1Up6yidSbfGjVP+B0E+Fvd4EQA32TnMnfDKmsmX36rKuaWlbQjUvhWl7hoZJflpHmK3zRejexRA0ksGjlbs+QRAMnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpXUncpn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpXUncpn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d590f4c291so5027745ad.0
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997295; x=1788602095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+bx+HWR1lJgM1IpCVaNlI18J07SWUFh64Ef3O2YpAQ=;
        b=CpXUncpnnvrvuLB+Fg4ojrZzSGnwrTN3kZkN69xW619n0Zst/ynY1HhErtHPEvrQUA
         n86qnV3ppao0z4gDC39rjx+sFtZTtkJmT8FrYg9V1ekF3QbTY3x9I9PkowZFzDF5kbaU
         K1cVlVh1kj7CzSCY6pjDhwwb58Kwh7NZOSbjE1dWi8VeU8WaxKlGYxabWy45CUcu+9az
         PArZv4c5Sp48HZrLiClVn8GkvNz5OvgAmDiaAE9wSXBQJzzin+E4YJD8wRl+enlRmgz0
         3bw50s5V4iNvPlCsKqdDV3lwL1ajGex+vnOF7T2/5TYfhlDGvv1f/Pu5XRULq4wTT1BX
         M3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997295; x=1788602095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+bx+HWR1lJgM1IpCVaNlI18J07SWUFh64Ef3O2YpAQ=;
        b=oS2UxIaeycfHF1QfA4oAvTHqhw33nNDdKh1y8TM/nJCytvjgU1ZsZAvIv9YKhMIy3r
         9fKvoKUvrIA3bU3NDU5UnVvC/B/2K3GwoFwmNjh9uhT1TaqUettGULllqUgNxqYKflsH
         aDjrGG6Pweiyh2/qbwbHysDxy7igOb7Doe/cqj8WBgvVcXGIJXp4ZwMP6oNciWTy+WKP
         pivps0elU2WUP8IIFYy+2eydnAs+feM8nqWAEsMRvmza3hMWA1FuAWBki0J3C4jW6Vlk
         6TCrLHY4soGERYZVoIHG05ivS3K6R5jIULdvW63GRrqoaqBh63dJ1bxm5U/PmduGODZq
         SVFw==
X-Forwarded-Encrypted: i=1; AKwUvBzLA2bdf0rM4tbK5a1w6HbmZsVaMidyaqkShAqbxyMUC3o9Q2EDCmAnfXpa+3KIU7+JAQalzi13gDs=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ/vkGdeLu70RMKY2dxqQ831810Rav/4pJjtmWSOv/Jr01xu2T
	p8RXHUtUR6pfNPnhFwGJJ5m7sibyreqsCZkxpLbiTmFLroLFC1yoTHJjH5UVLnOR2OE=
X-Gm-Gg: AYBFou2PvpAESOkZ4LmQyzneSv0vzlYmkKPsrJFBNoLZkt+1RUACQ+nqdG7+lvI7+iT
	fQOqc3IcwuY309pd7UgstSMF+4ZEBQ4dON5UgR6N6ubwFPEKPmWu/Dcr6IRbSjEp157l6g+k/mW
	zgH4ne+MhoNYP2MKnsGmOS1E0rnqWOtqwdWtSLI88WeginOUWzFYunWn+q0O30pRc7OFjQ8cHpx
	Zfj8Vr5fSqexwsrmJ9TqFC13QAvSY2behyLNJpup/WfsGzXhJ2Ls0zx+03ays4H4SI0PDQGH+Q+
	8u34lDr3cMSX3ppwvvwHMDola6QYiEytNJfD7CQOtc88Qxs6jFlu0Cy2cvE7KERBAX4C3p5v3L3
	8t86z3el8iah8CsW6mtzKTawxuEjViXjwNhC4CiYoIiQE6MP1r7jG1He3MIhHdqYzkPz/7BTDgS
	EmuCkbwiooUwwwi8TJvC4GNFTIf2uM6ieTer1Sc0erYORroJLoTFZ4e9z8W0ocCG2oYmrYmSXPv
	tRjTE+csPfbyZ3NtiB54TkVxeRT4p6R8g==
X-Received: by 2002:a17:902:d2c7:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d74ce38075mr120434055ad.0.1787997295482;
        Sat, 29 Aug 2026 02:54:55 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:3104:d691:c7eb:3b03:2c8d:127f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm15775697eec.6.2026.08.29.02.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:54:54 -0700 (PDT)
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
Subject: [PATCH wireless 1/2] wifi: iwlwifi: pcie: arm the product reset at probe
Date: Sat, 29 Aug 2026 15:24:36 +0530
Message-ID: <20260829095437.44716-2-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829095437.44716-1-navonjohnlukose@gmail.com>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver already implements the platform-level device reset (PLDR):
iwl_trans_pcie_call_reset() walks _PRR and evaluates _RST, and
iwl_trans_pcie_set_product_reset() arms it over the vendor _DSM. But it
is armed too late to ever help.

set_product_reset() is only called from iwl_trans_pcie_removal_wk(),
i.e. once the device is already being torn down. On these platforms the
_DSM dispatch is gated on the firmware reading the device's PCI ID back
out of config space:

    Method (WIST) { Switch (ToInteger (VDID)) { Case (0x272B8086) {...} } }

If the device has lost power VDID reads 0xffffffff, WIST() returns 0,
the _DSM never reaches the vendor functions and acpi_check_dsm() fails:

  scheduling reset (mode=6)
  ACPI _DSM not available (-19), cannot do product reset

So the reset stays disarmed, _RST falls back to a plain function-level
reset and the device is unrecoverable in exactly the case PLDR exists
for. Observed on Intel BE200 (8086:272b) on Meteor Lake laptops, where a
D3cold transition removes the M.2 module's power rail and the card does
not restart when the rail and PERST# are restored.

Arm it during probe instead, while the device still answers. The mode is
sticky in the platform's namespace, so it is still set when the device
later disappears. _RST is only evaluated when the driver actually asks
for a reset, and a subsequent non-product reset re-runs the existing
disarm path as before. On platforms with no such _DSM this is a no-op.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221695
Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP errors")
Cc: stable@vger.kernel.org
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4252,6 +4252,11 @@
 	iwl_trans_pcie_check_product_reset_status(pdev);
 	iwl_trans_pcie_check_product_reset_mode(pdev);
 
+	/* must be armed while the device still answers: the _DSM is gated on
+	 * reading its PCI ID out of config space
+	 */
+	iwl_trans_pcie_set_product_reset(pdev, true, mac_cfg->integrated);
+
 	/* set the things we know so far for the grab NIC access */
 	iwl_trans_set_info(iwl_trans, &info);
 
