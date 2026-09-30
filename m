Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96339E9DD
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805628; cv=none; b=Cm2xXWC8xKm5pBVo1p4ovIdv2Lj+FEhyyJUnE+n/r3aff7lhRv4kdkIUQ3qCRbrBTFZOj9VBkXxyV2HFrqGY4YKlJLnYlrTygUkp5bxt/JEJl4kYxX680gqinUTR5SKtyYplxPFOHUv271vg+fN1ZT1/RiRTxq138f9Hot7e1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805628; c=relaxed/simple;
	bh=oRJCoYpaB5eeVBogixaSGbXQ13g5p50g5CkYemQTE6s=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EBoeERqhB0LUaz04CTxfFtwYkgVaWC0ggRkWO9huMfhxh+pDYmd3VhRQPB069h4JCA8TfpEQnNSVf6x/0j+IIeIbCL3oQdPNJRnOFAKxh260QZLPiAusRmUmG36ogmd6sd0Et8esWb1YAqILV0YX1IE6PU0JS0jIkNma2E6hQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=PjjcrF7y; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="PjjcrF7y"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145ab8fd39cso5358297c88.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790805625; x=1791410425; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aw7HhIOhxG4BY9CNCyb0hDDKF75Nqn5paSwOxIM+mOQ=;
        b=PjjcrF7yfKgfHpRecwxZSNxlLnKIqebacWPEJ/LudZwrHNtNxqAFg6hB0TYUJvncER
         5zPXZol1HRg1By0zwTvMqE3bEBrOvZOBR+1evz1BJX57HOTbyPlIHPvB49X7qeeuizR5
         9t9miOwd3lwJXSoT5D8irGznBzf2eyErv0AWruz3N+zA+TDS3ck+rn3e8Y4F94D85A8a
         DhWe1RXxUEHdWzw63Xzbaow31tC9bdRH7dTJQVFx12yIeYDpujk5lsn45WHOyklgRQC9
         8ooGsS4nkt2+7pLR49ViJM6rFRAPWJK+3BeIzONa8/A72fV//RgwLD/jXXVKJ4ZxmniF
         9h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805625; x=1791410425;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw7HhIOhxG4BY9CNCyb0hDDKF75Nqn5paSwOxIM+mOQ=;
        b=pzdEMI9IN9DlzXPbj6HibLccPR8pWxIqw7u4w1T71w2407/RxMv/eKlT/KAc+41gee
         cW7ZTor1Lm8TWHHfr0GfVHcGVBZl2ntcmVuC+Z43BdvKW+R6gFhtWlOZzNzZ/6V6SlBi
         38ZD+OPGqsrCyCCFMnF+yg88NqRErS0O7Y8ENdWu5pz9kYGcM2yj2SCHbqsCotYs9BMQ
         HKcxBNMwRnfiSkDWACrvZjlntv8pA/2QEYUhWbg4mjIFJaehgRAV54Kbf8+uV6BgMahG
         46sgLeGAHHUFJpfLV6YU+LjSiyfi8SWU3Fh+93pwDrNHFJypqtHH6T33Y8DoD1adCSVo
         LwhA==
X-Gm-Message-State: AFuF++meTOeog7fdN0zpsoZuVEqZkFlgv2Ihm5s+5fsP4LxYeHQWH53p
	gHkmrz7430dEA1SGCEDEog8wyVUieU54yzIe7PMFR3VcfFkyul0P09BC09izvuKVhmOgNytzYPG
	jmXYD
X-Gm-Gg: AYBFou2F6hClIQTcKGj6aV5457NNUNPQAkd5cJvLoERwCeQWMnPT2TXxKgxf3nJHq0h
	WC7TL+SuXErujIMNTIR0mBH+YR2m8UiiRGBeWNHu87u0lBk8MF/RWK8oEOg2k3iKNwqhpWFSGlT
	jz+0HOboEmNvwaTPfGyYATNHfZWffQOWJF8BdMPB6f6V3393uf6tpNoGVbl2uDIM99aA9Yyma48
	uxerTuUgNp/iDnn+sKXJavoF+KcPlTPNAjOBRFaI0bf1xKdq5puMilRC9xHwQ3YZHV10fHeHqkZ
	o2uooVtSW5zusHGPNPH9WGbQxw9g3P8sgzDMGhPIPvJVS8i34mNasPNK0lBp3jGn56EzhZM1OFM
	i4EdWOK2EYKem7s0xlUKIF23z1RR7ld8c60aCr0BUOWL7182lOyphQkOTyO44eW6LrF/UM3hpmM
	lxR266oJsErpQC1sFZEn1A3jWXbXMPtlXF6e8U7pr58ReeP7IfqD4JgfX/Y07H/GM=
X-Received: by 2002:a05:701b:21d3:20b0:144:c127:dd1a with SMTP id a92af1059eb24-14d3691300fmr2546635c88.38.1790805624885;
        Wed, 30 Sep 2026 15:00:24 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df40dc189sm855426c88.11.2026.09.30.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:00:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIGxpbnV4LXBjaS9uZXh0OiAoYnVpbGQp4oCYUENJRV9QT1JU?=
 =?utf-8?b?X0xBTkVfU0tFV+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5j?=
 =?utf-8?b?dGlvbik7IGRpZCAuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 30 Sep 2026 22:00:24 -0000
Message-ID: <179080559722.116660.12892772212991345354@kernelci.org>

New build issue found on linux-pci/next:

---
‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’? in drivers/pci/controller/dwc/pcie-rcar-gen4.o (drivers/pci/controller/dwc/pcie-rcar-gen4.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: error: ‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’?
  307 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
      |                                     ^~~~~~~~~~~~~~~~~~~
      |                                     PORT_LANE_SKEW
drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: note: each undeclared identifier is reported only once for each function it appears in
drivers/pci/controller/dwc/pcie-rcar-gen4.c: In function ‘rcar_gen5_pcie_init’:
drivers/pci/controller/dwc/pcie-rcar-gen4.c:338:37: error: ‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’?
  338 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
      |                                     ^~~~~~~~~~~~~~~~~~~
      |                                     PORT_LANE_SKEW
  CC [M]  sound/soc/codecs/da7219.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:9c96bb06403e0f385b3d6d522f160cd82ba4b932
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  bc80f6c85a8e97bdb69604f82af37179fcb01c38

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6abd7df914cd2ca558e86834

## defconfig+lab-setup on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6abd7de014cd2ca558e8681d

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6abd7db714cd2ca558e86606/.config
- dashboard: https://d.kernelci.org/build/maestro:6abd7db714cd2ca558e86606

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6abd7de614cd2ca558e86820/.config
- dashboard: https://d.kernelci.org/build/maestro:6abd7de614cd2ca558e86820

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6abd7dea14cd2ca558e86823/.config
- dashboard: https://d.kernelci.org/build/maestro:6abd7dea14cd2ca558e86823

## defconfig+netdev+nfs-root-boot+ltp on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6abd7def14cd2ca558e8682d/.config
- dashboard: https://d.kernelci.org/build/maestro:6abd7def14cd2ca558e8682d

#kernelci issue maestro:9c96bb06403e0f385b3d6d522f160cd82ba4b932

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
