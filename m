Received: from mail-qv2-f11.google.com (mail-qv2-f11.google.com [74.125.230.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C671F2B88
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678407; cv=none; b=NJvxfmKNfuUeeM8HJWIEjfJXIY7xQwL6S3C497gfhvWs5euwd/oZrKPxt8Ov1cnZH9XWh5AE7h3D4KlSGr6uN4Cov1K9JRnngNKogevpHlDyPoC8+WdcbMqRL46ogwJ939F8WzmzqGHtT6zUQMRRPVQ10EajOdgjceHkLPwMOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678407; c=relaxed/simple;
	bh=ndXckvHALTAO4M0gyPinxjPONrksqpveeSnihZMtTkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEiTjQJzli68ermAY+zyzFChrDUlETibzjsPRcuBm+uZoKwQSyMUbzX4ruUPtUT7eVyD1BtM6F3UI/OTtLbpp8Nz6CB+BXTA5pbRl3lB/7d5XyI45EoeQ1t5XrygZb6oC2/wAzDyWkpYKktSXSdcgYtg8cETDz7Hb5sSx/vzODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj39FRjH; arc=none smtp.client-ip=74.125.230.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj39FRjH"
Received: by mail-qv2-f11.google.com with SMTP id 6a1803df08f44-9195de4174fso6688906d6.0
        for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791678403; x=1792283203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XeJjl/io3+aKvrUjCul3f6wSV2JN17uTopzSqxgAVR8=;
        b=Hj39FRjHNKSFNTMYh9OVh8Zij1tz0BMrRxAcLwTLdaLUdYUSMVVggp3yZ3DKWMsUAK
         mV0OA8/4sGl9XjJEMqff4SpLkwNRF3i80VOkEdvGWPPdiw3P15qrUU+yM5foqamqzDiT
         hv8+2LmixCmtISJcJ/HnGDxb0n8akdfYgOGW7mXuC6Je87SYtYkINf0LIrf2CPu7EsE/
         UqJYaSA39ngQ47x6uDeDw0cRZ3wMGd7dCDh+l30ClXydAvZYnQ4v7sFhllTS3FQ4UZwP
         k6Mc/PHbdhqHF5A9MKEkYDW8Fr3iEbxGnCJLK/8zf3QsacfnSaBDpz61p7IS9Fcz6nm+
         1FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791678403; x=1792283203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeJjl/io3+aKvrUjCul3f6wSV2JN17uTopzSqxgAVR8=;
        b=TTBqOQtYxZv/BanPYrES413KGwdRHTy5Q0rJ8b6Smh7O658y4f2RUnl2S3NEt4Kox9
         RLUkjaDdQBvh1hf5+eKpfQ4cNYU268eqVzQgz2zhLR0fPvNWyrFjCmDRxbzjqQOuN3oB
         NhloWXINIwnhl2/4JLr7Wsu4ZTw9Zpl1e5uI/mkC6O50BVDHKvI5r7RreBH5kaXyTtqo
         IfRT4YesJYXvF+LBeDEWIWRXZtiFH2pMevA5jzJRP8pVzuPH42QYyDEz4E6pFQfq9lEB
         dp+6zzi04ajyikzBZ7V3+v3KAUFLRxTXw91amR87EQO0WLiVbsRQeask7Qf3ET+syqhK
         9ZJg==
X-Forwarded-Encrypted: i=1; AKwUvBwjPVTXSJVn7fmJU66STcFVJDMn1GKbwAYd8sMCr8G1Y6CdD4P2pG5VCU1KF1ESK4v32M901uaEzFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA9eodLJn7Pqq0ToXp87A1j+9rsRuIdjDMj8kfiT0FaHN8Xkwy
	sYrUHFkw4lO43mLw+a+xXS0lVbR4Xt5Z95ohsRygBJXbRkKotyJy5omX
X-Gm-Gg: AYBFou3iRgk7e8v5TcIhnBrKOGw5PbmUjP+tbUfZzuZB4A+L5cn3PQomPQEAPuQpYL9
	2chM6yn5+E8waYr7LO2WcIPc7UgcG25tjeCRYp8fqgVsYl8EDFCAIuDCf0pBVPokM07x1Ti2WGm
	ByNJP4FlSBIHYJWQzqk7lFleUQwgY6jh16QLVCxEOItSsfsLAMcFDhOOneay8LAVF16OGiG/TWV
	PTq1ybWjqPCE6H4cHTvaUsrAkigwPH/mU3pO7q7KiCoq35HUY2300jgXIZGhdFuCGddT+XKvEzD
	+j0gsC8qKMAU70nthtFFpiBUNVUJ76tzld5/vMKHsEFrN2q2IMk6Ic/KLO0zUW13Fu8MWA1QwDp
	5a9+07C054SCL1kgtMYIbLGGQgvGy8y8PKGrJ8uquSCoSkRWSsrP6BYrx/IouIIjKPMA/IkUzDh
	OS3qSJjTnmLF7ZK7AjRtzDUd7mn5F0SPrh34aaRHQqjI67a9x2WPiSAcIoxCAC5p3iZU0=
X-Received: by 2002:a05:6214:21a6:b0:914:53c0:1a4b with SMTP id 6a1803df08f44-91b557c2adcmr107067156d6.43.1791678403571;
        Sat, 10 Oct 2026 17:26:43 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm57407466d6.45.2026.10.10.17.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 17:26:43 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: PCI: mediatek-gen3: MT8189 never wakes from s2idle with ASPM L1.2 enabled
Date: Sat, 10 Oct 2026 20:26:31 -0400
Message-ID: <20261011002631.1105346-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ryder, Jianjun,

I'm running mainline on an MT8189 Chromebook (Lenovo IdeaPad Slim 3
Chromebook, board "quigon" in the skywalker family, with an MT7922
Wi-Fi card, 14c3:0616, on the PCIe port). When ASPM L1.2 is enabled on
that link, s2idle hangs every time. My question: on MT8189, does
L1.2 across SPM sleep need anything beyond what pcie-mediatek-gen3
does now?

Setup

- next-20261008, plus the posted Genio 520/720-EVK series (which adds
  mt8189.dtsi, from Louis-Alexis Eyraud), plus the board DT. The PCIe
  node is the one in that mt8189.dtsi ("mediatek,mt8189-pcie",
  "mediatek,mt8192-pcie"). It is the same as ChromeOS's node except
  for the clock list. Pins: GPIO48 WAKEN, GPIO49 PERSTN, GPIO50
  CLKREQN. The board overrides the T-PHY to generic-tphy-v2, as
  ChromeOS has it; v3 froze the SoC at link-up.
- System sleep: the firmware has no PSCI SYSTEM_SUSPEND. As in
  ChromeOS's DT, s2idle uses an idle state with PSCI CPU_SUSPEND
  0x020180ff (min-residency 0xffffffff). When the last CPU enters it,
  TF-A and the SPM put the SoC to sleep.
- mtk_pcie_suspend_noirq() returns early when
  pm_suspend_default_s2idle(), as in ChromeOS's driver. The bridge
  stays in D0 with its power and clocks on, and the link is left to
  ASPM.
- From ChromeOS's mtk_pcie_startup_port() I added
  PCIE_LOW_POWER_CTRL_REG (0x194) BIT(8), which force-disables L0s,
  and PCIE_AXI_IF_CTRL_REG (0x1a8) BIT(12), the AXI0 slave error mask.
  PCIE_DISABLE_DVFSRC_VLT_REQ is set, as upstream already does.

Symptom

With pcie_aspm.policy=powersupersave, both ends get L1.1 and L1.2
(ASPM and PCI-PM) enabled:

  00:00.0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                     T_CommonMode=3us LTR1.2_Threshold=61440ns
  00:00.0 L1SubCtl2: T_PwrOn=52us
  01:00.0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
  Link: 5GT/s x1, CommClk+, ClockPM- on both ends

After that, every s2idle entry hangs:

- All devices suspend. With console_suspend=N and pm_debug_messages,
  the last line on the AP UART is "PM: suspend-to-idle".
- The EC sees the AP go S0->S3, and S3->S0 never comes.
- The RTC wake alarm doesn't bring it back. Only a hard reset (EC
  reset through the GSC) recovers the machine.

What works

- L1.1 only, with link/l1_2_aspm and link/l1_2_pcipm cleared: 10/10
  s2idle cycles, RTC wake, Wi-Fi back after each one.
- L1.2 while awake: 200 MB over Wi-Fi with no AER errors and no ping
  loss. At idle it saves another 25-50 mW over L1.1.
- Workaround: clear l1_2_aspm and l1_2_pcipm just before suspend and
  set them again after resume (a systemd sleep hook). 10/10 cycles.
- Adding the L0s and AXI bits above made no difference to the hang.

ChromeOS builds its MediaTek kernels with
CONFIG_PCIEASPM_POWER_SUPERSAVE=y, and the comment in its
mtk_pcie_suspend_noirq() says "It's recommended to enable L1ss
support, so the link can be changed to L1.2 state during suspend."
So L1.2 in SPM sleep seems to be meant to work on this SoC. I haven't
checked the L1SS state under ChromeOS's own kernel on this machine.
Since the AP gets as far as signalling S3, my guess is that something
outside the MAC registers is missing.

Questions

1. Does MT8189 need anything else for L1.2 across SPM sleep? For
   example:
   a) The 26 MHz reference clock and CLKREQ# in L1.2. For MT8196,
      the mainline PCIe sphy keeps pextp_ckm on in L1SS_L1S1
      (RG_XTP_CKM_EN_L1S1). ChromeOS's MT8196 pre_init forces
      pcie_26m_req and bypasses its ack (PEXTPCFG
      PEXTP_REQ_CTRL_0_REG) and switches PEXTP_CLOCK_CON off the
      low-power clock. Is there an MT8189 equivalent? The T-PHY
      driver has no L1SS handling.
   b) A resource request or constraint for the SPM/TF-A, telling it
      that PCIe is in use so that a clock or bus resource stays
      available during sleep.
   c) PCIE_RESOURCE_CTRL_REG SYS_CLK_RDY_TIME. MT8196 sets it to
      10 us; MT8189 leaves it at the reset value.
2. Is anything in the setup above wrong for MT8189? For instance,
   nothing on this DT platform programs the endpoint's LTR Max
   Snoop/No-Snoop Latency (both are 0).

I can test patches, read registers before and after a sleep attempt,
or try other settings. I have the AP and EC consoles and can reset the
machine remotely. The board files and patches are at
https://github.com/zoan37/lenovo-slim3-chromebook-omarchy

The debugging was done with help from an AI assistant (Claude).

Thanks,
zoan37
