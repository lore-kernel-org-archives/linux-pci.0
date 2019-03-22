Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7742C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17ED2190A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfCVQSe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfCVQSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 12:18:34 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Ml6du-1giEin3Zc4-00lUSs; Fri, 22 Mar 2019 17:17:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [BACKPORT 4.14.y 0/8] candidates from spreadtrum 4.14 product kernel
Date:   Fri, 22 Mar 2019 17:17:15 +0100
Message-Id: <20190322161727.1153278-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6vAaVJbqlIwQBNpuDE68PRSmIoV/qORKtjo7MHYPHVEgEs0oB84
 KExJJKI1WtCO337J1DaMAQcxmDfxiANPnwcriBx8AmTEWexv+nZJmzag1XIWbzEbDBzsqBH
 X5PfxXpBmvLuuRPq2UaXdImoyJ7a+FFKjhZOwn7m4aRO/kHtj2c/orUHTcE3DXLpfYZAyAg
 d9pzyh6KAuG1uShb40rlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iQVWtFWcL1k=:GXC6xumF8zx4A25fP7K+D9
 M1tZAfum0zz7BJuE+MvBF65D+n/vSzaHcNuYC7Mu6K2+Xbg8UXtqbqYHBH13WqNaTUu0nL7wO
 rquLbvspkrsPzm5E8gdrTgwZBFBoyLfOYf21A3ycMXMNg8pcIOwn+X5aKpD8U++4PgzXZz+de
 UpujpZQDgy22ZBeuWkrLOO8vkYA4Iix2KYFDRWoxSwmKh76i3Kfbg+9zlblHwKiMKdbbczWG9
 8xBy7Rag6Zs6TpAOvr8ERZM+qtsQwGtgxyU2f7PGJVSVFojaEeGK6uxOVB6Ou2h+mJYbhUu3l
 XAyTmDQXDQpQsKVDr75EUNHRI++cXO6h3RqneCjZ0SlARpNdOqMSKC5r+y2VFNA5rY83siojW
 +KSc0kFE51AUNdn6MEN+TcjUttGfXEGsdYPMTShzYSxKBaa1jbrq+me3mp+ZRXgH6iGi6yEXd
 3yaEaYEgeERTZJLjWnuWUAW5im5HT+3TU/PiWhNf/etLbpn8udlVQydYCkJGKBsK/vcpr7qOU
 unfMTcAHSaJN4GyKDkjfc3W170emh/FjJzmee+E/Dvz2K0ckD1k+vRCWBHLQE5c/ym7bUYRMD
 xelEWdhvcVAeYxg4r/A+IFl3FiaN/zYbfBDY/Qm0gurvVOrqVXktY7nLWc0PkN/1EYrCdUYUe
 KUNfN3Oue5vOIfPhmaQJ9g1Z29KDZYKz3YngGn7z7RuZH4+5eg3Wkw0uOymbVleyzgFsv+Bx2
 GMdvfHhmksLRtvmEeCh2cA6VAgdZQWbv6J+EBA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I took a scripted approach to look at some product kernels for patches
backported into vendor kernels. This is a set of (mostly) bugfixes I found
in Spreadtrum's linux-4.14 kernel that are missing in v4.14.107:

83dc7e3dea76 scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1
099a95f3591a PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
1cab826b30c6 PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
b330104fa76d PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()
36d46cdb43ef rtc: Fix overflow when converting time64_t to rtc_time
1b5d43cfb697 sched/cpufreq/schedutil: Fix error path mutex unlock
5fb5caee92ba pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
f25a646fbe20 power: supply: charger-manager: Fix incorrect return value

Only a small number of patches here, the vendor tree is fairly close to
mainline. All commits apply cleanly through git-cherry-pick.

Baolin Wang (2):
  rtc: Fix overflow when converting time64_t to rtc_time
  power: supply: charger-manager: Fix incorrect return value

Enric Balletbo i Serra (1):
  pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.

Jules Maselbas (1):
  sched/cpufreq/schedutil: Fix error path mutex unlock

Kishon Vijay Abraham I (1):
  PCI: endpoint: Use EPC's device in
    dma_alloc_coherent()/dma_free_coherent()

Niklas Cassel (2):
  PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
  PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be
    writable

kehuanlin (1):
  scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1

 drivers/pci/dwc/pcie-designware-ep.c   | 12 +++++++++++-
 drivers/pci/dwc/pcie-designware.h      |  1 +
 drivers/pci/endpoint/pci-epc-core.c    | 10 ----------
 drivers/pci/endpoint/pci-epf-core.c    |  4 ++--
 drivers/power/supply/charger-manager.c |  3 +--
 drivers/rtc/rtc-lib.c                  |  6 ++----
 drivers/scsi/ufs/ufshcd.c              | 14 ++++++++------
 drivers/video/backlight/pwm_bl.c       |  9 +++++----
 kernel/sched/cpufreq_schedutil.c       |  3 +--
 9 files changed, 31 insertions(+), 31 deletions(-)


Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

-- 
2.20.0

