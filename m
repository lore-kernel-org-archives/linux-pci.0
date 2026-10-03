Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C63A6B89
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018422; cv=pass; b=k9WFrue45t+0VTpsO4PhKGk/i+2sEUa9Ntz7kIc5xRD7VpuaRvwOFa6KYnCJiHpnL+Mvcq28/hRzjLolkGm56Kyd+pZLSdkBZxbfrNdh2m14GkQK5JBYNU55OPnF0pr5A4v5S7tM+7/csyudY/HDa1Mv5exNh2cR6EOpa1rZn1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018422; c=relaxed/simple;
	bh=HpqvNikVLDJ70kjb8gJjkVOTZdeTnHoE1zMdMiokrPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f9jUkBzv5A0U6ylupmOJBTNVKGzjU+5ug3NDqXK2uMbArTypKEsyMsDj8v6YFfyF8yDxA1TFZypYUiP735BMrQA/+JBrqj/j12q3aCFl3Vqd6kcmoA6Szfx0F1WoCGHo2HTyaDUdNYmww9vA2wuTNViyIQNxoECExlCsUWW1Hl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzIEhAye; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzIEhAye"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so162994c88.0
        for <linux-pci@vger.kernel.org>; Sat, 03 Oct 2026 02:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791018420; cv=none;
        d=google.com; s=arc-20260327;
        b=nX5n0lRIULKgoI00bhq1R+SgDbGlq7pkGe0/SBCjC9BwKQhp5BP99y2vb+I1btjt8I
         FjaaqBLzjnlbBeco11TUIHs9eMmMW8AJ182BCQCjCxlWsADDeVG6CmEAvnVOZZVOUsj5
         GsXXspjVxRWMX3CUyQN53+gufUns0DBguClUb8sLc9TXHADL7ecc+oZEFcc39cZHJ+Ov
         bWQCQZeWdKzL59y6b0mjQMSJLYogYwUQP9/4h+oK1PbBvQ0XGk/hfaquF7cViDKMZcI3
         HPAVXUV5le96vAwG1O7VIbEcwOHIrfEQ2ejAKURL0QEVqwWBuXmbXRD9QhdEbOrSkpEF
         Lung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HpqvNikVLDJ70kjb8gJjkVOTZdeTnHoE1zMdMiokrPo=;
        fh=1DWHxen6BIPmlD4ydIBxCBhOkbjWCOl/p9XsE/AL968=;
        b=CD7dxAwumTOBNhQ2l5RRZhkvwG2A7eAphC1FTtLQLE/2R4di62pMX1ax7lQWpueAM7
         u9KB9UMfDUMPfLXMwy7dWex7yTs6e067qahdqTjtMzhY0O1Uh1FPLHU3eHb+PEilVQsd
         a2sTAaYr5dIf97aRRrfPBeEmlzIm30cPUeC1sMFDyIjYs2FlkhbqWf+RJuWdh3SdbuD8
         aiztZS7wi8vnsXZWUoPDGQUFCSvDReOFJJhPWvk9jPX2dryYkM9ksxM8Q5m7flT606Zk
         YB/J0RRy4rbAo1dGnSALRtvTDHlhEsrUnVIxQq812IhhbuFDMmssTJ2JHCjpV15MaUnK
         8Hpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791018420; x=1791623220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HpqvNikVLDJ70kjb8gJjkVOTZdeTnHoE1zMdMiokrPo=;
        b=UzIEhAyeex5HLTc2GwWHYBBB9qpLlD4JaCxQDk9X4y5V25O61x3rTwMMutU1ycdo9g
         lbwYKWYlM4baJhjtQg5uiQyEVeHnFf+HTMvYbLQ3s9UZ+9lV8JOt744/sC1WxTwjJmwO
         jmHOJcBPCM4rBLXbun3aU/5yxXZPEWvPY8+/DpIkg6YWW5lyhllH4I6svGnJV8mxrBQ1
         9y88Cqwp5RttzvEelmFEgE3EoJKLysB9WiYsGOlJQpL4/XWK1VhR3A9jFKIXq+dTV8lW
         PZGZvEAf+UcGhJVhwrGIn5WnmqCKrpkt5yYcPoM6vftj+AKCWlDDi7vNLFZZesCSJwr4
         gl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791018420; x=1791623220;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HpqvNikVLDJ70kjb8gJjkVOTZdeTnHoE1zMdMiokrPo=;
        b=BJfqjKIIxv3WvT+elQ20faSHlLrQmsPHmb6xH34Do56LywckpCS/DXZ5pv1dNgob6F
         nwySMKczoZYNbWKj9rGFJ4Ufm0oPXggKWSJ/ZveAAmfVaDc4p6vyLIPDcO/zIhA6DUvP
         eApLjdub2o4QDEY3QDkhdI0DORed/hfW+PnEHMIm9fIcIbtqORAk6aZ5SEflbafedfb4
         snU7F/cm9ZPk6sCHgusfRi1JX+2Dr3WiraXn0KUSWYfICdPsUa8U1uGabZNvHAm7c/hh
         yKJigTI3K59BL3sWEG37lxeogxwTLa4hqaqfVIFoYjRmfpTerSlDuj6wM//GUbYS6QdD
         G2mA==
X-Forwarded-Encrypted: i=1; AKwUvByI1TbHMp4BXHCBsT/EgmR5IYALo6JTC+ewmpSLuzDLirfj3EvPhTAD4TC5iQYTUGHNqS281KZlWfg=@vger.kernel.org
X-Gm-Message-State: AFuF++m7YeYKOfCRES/hjk6c09oSV/ZqZTS/+QEfH+bgkZTOsH7dPOVh
	jl904flULRA0Qi1D17W/KQfxX0r4LmiW8jYffMDGxMJc1r0CYC9Ad8bhiUf6EAHvA4Fnq9gHexL
	FG9dTgqwl3joQJZwzuerJC2RNPp1EhGo=
X-Gm-Gg: AYBFou3KACEylrFDtXtpDfBjZcVLQWry417cABq0OUn2pC1VlIdmWUQCyEmzIrgzTxL
	YWOYA3Jotk/iTth54dBKw+/KgderiJz1Umt2cadu51EHAWL0AyUuhK9CAaNyJiZyuzoGZ6+GLlk
	xSZiESQNrgS39XDQlM5WN9ZpqBx6XNqNyF3omXOtnd3rxB5MBfGqdW08YWAz8e7rNvir0p0zSug
	QdPpbZ4Ywf9P5moXsGfb3RMjr8RpdP1RvVKx8DsjE8nPT7v1yn0cJPnQmjUSSCqCvUmytqf7mp+
	Qxk10du3GgHw+ldcXCvQj5YSQHoMoxpH+4KXsZ+4NSWTPOd04tNm
X-Received: by 2002:a05:7023:889:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-14f5c6e4b77mr6420591c88.25.1791018420013; Sat, 03 Oct 2026
 02:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Roux?= <franzelfranzel@gmail.com>
Date: Sat, 3 Oct 2026 11:06:48 +0200
X-Gm-Features: AclHuK-D1pWutY4-GyV2il5anLEEUn-RjWwNXeCIaa0lBTwPNQQBpHP4LHwav_Q
Message-ID: <CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com>
Subject: [REGRESSION] PCI/pwrctrl: WCN7850 not enumerated on X1E80100 (Surface
 Pro 11) since b921aa3f8dec
To: mani@kernel.org, brgl@kernel.org, bhelgaas@google.com
Cc: krishna.chundru@oss.qualcomm.com, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Since b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
on/off, destroy APIs") the on-board WCN7850 Wi-Fi of the Microsoft
Surface Pro 11 (X1E80100, board "denali") is no longer enumerated.
v6.17 works. v7.0, v7.1 and linux-next up to next-20260929 do not.

#regzbot introduced: b921aa3f8dec
#regzbot title: PCI/pwrctrl: WCN7850 on PERST#-less qcom port not
enumerated after pwrctrl rework

Hardware
--------
The WCN7850 (pci17cb:1107, ath12k) sits behind pcie4 (1c08000,
qcom,pcie-x1e80100, gen3x2). It is powered through qcom,wcn7850-pmu
and pci-pwrctrl-pwrseq. This port has no PERST# GPIO, so the only way
to reset the chip is its wlan-enable line.

Symptom
-------
qcom-pcie 1c08000.pcie: Device found, but not active

On some builds there is no message at all. The Root Port 0004:00:00.0
enumerates, the endpoint 0004:01:00.0 never does, and ath12k never
probes. Bluetooth on the same chip (UART) fails too:

Bluetooth: hci0: QCA Failed to send TLV segment (-110)

Bisection
---------
git bisect start v7.1 v6.17 -- drivers/pci drivers/phy/qualcomm \
drivers/power/sequencing drivers/clk/qcom drivers/interconnect/qcom \
drivers/regulator drivers/soc/qcom drivers/pmdomain/qcom drivers/of \
drivers/base/power drivers/pinctrl/qcom drivers/iommu \
drivers/irqchip drivers/firmware/qcom

The same .config, the same DTB and the same command line were used at
every step. Each step was judged by whether 0004:01:00.0 exists after
boot.

good 4c4132489201 PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices
good b35cf3b6aa1e PCI/pwrctrl: Add APIs to power on/off pwrctrl devices (*)
bad b921aa3f8dec PCI/pwrctrl: Switch to pwrctrl create, power on/off,
destroy APIs

(*) Not booted: it only adds functions that have no caller before
b921aa3f8dec.

What the boot logs show
-----------------------
Before b921aa3f8dec, pcie-qcom (built-in) probes at ~1.8 s, before the
pci_pwrctrl_pwrseq module is loaded. The WCN7850 is still powered from
UEFI (wlan-enable high), so the link trains at once and 0004:01:00.0
appears on the first bus scan.

After b921aa3f8dec, qcom_pcie_host_init() calls
pci_pwrctrl_power_on_devices(). That returns -EPROBE_DEFER until the
pwrctrl driver is bound. The host goes through ~11 aborted init
attempts, each one powering the PHY and controller down again. It then
succeeds at ~2.3 s, but the link never comes up.

pwrseq-qcom-wcn requests wlan-enable with GPIOD_ASIS (see the FIXME in
pwrseq_qcom_wcn_probe()). The later "power on" therefore sets a GPIO
that is already high, and the chip is never actually reset. With no
PERST# on this port, nothing else resets it either.

Tested fix
----------
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
- GPIOD_ASIS);
+ GPIOD_OUT_LOW);

The chip is switched off when the sequencer probes, then switched on by
pwrctrl in qcom_pcie_host_init() right before LTSSM is enabled.

The FIXME's rationale (toggling wlan-enable would drop a link that the
controller cannot recover) held while the link was trained before the
sequencer probed. After b921aa3f8dec, pwrctrl cannot bind before
pwrseq-qcom-wcn, and the host cannot finish init before pwrctrl is
bound, so power-on always comes before link training on this path.

Results:
b921aa3f8dec + fix: 0004:01:00.0 at 2.4 s, ath12k OK, Bluetooth OK
next-20260929 + fix: "PCIe Gen.3 x2 link up" at 3.4 s, ath12k OK,
Bluetooth OK

Questions
---------
1. Is GPIOD_OUT_LOW (dropping the FIXME) acceptable now? Or does some
user of this sequencer still train the link before it probes?

2. More generally, should pci_pwrctrl_power_on_devices() power-cycle
an endpoint that firmware left on? PERST#-less ports have no other
way to get a clean reset.

A patch implementing this (also dropping the FIXME and the code that
kept the firmware state) follows as a reply to this report. I am happy
to test anything on this machine.

Environment: Arch Linux ARM (aarch64). Command line: clk_ignore_unused
pd_ignore_unused fw_devlink=off pcie_aspm=off. CONFIG_PCIE_QCOM=y,
CONFIG_PCI_PWRCTRL=y, CONFIG_PCI_PWRCTRL_PWRSEQ=m,
CONFIG_POWER_SEQUENCING_QCOM_WCN=m. Wi-Fi firmware:
WLAN.HMT.1.1.c7-00108.

The full report and the bisect log are in the reports/ directory of
the GitHub repository franzelverbier/surface-pro-11-linux.

Thanks,
Franz
