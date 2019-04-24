Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19BC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B484205ED
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+WDYEss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbfDXTRy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:17:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388804AbfDXTRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so26645154wra.12;
        Wed, 24 Apr 2019 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGOU3ia6g6f+mcCeqoj5rUs2fETF3ERMMj8iqSjiOI4=;
        b=N+WDYEss0BjujrTkoVQFmlZMauTQnxRdnQZfZb7Pj5loUGC4okCuuv16tnp3aMqup9
         iAjLrSNm+TMJmHj3YYK9T/bwzZxTQKmGcK/m44oWL5evBfcPwpv2eoAi9aqBLRf40l7b
         ZsYLe15al+e+C0axyxR8ts7wuFEGb5+V5SLcItizyuxglNbmNpn9ZJIUpYxtl2BnxfHM
         cMMEPrEFkthMa9Qfs8gl42cjef5Z4uJaPHZZ7LyHX/GXlTmyzP2/mOIFXaU55f72KVC6
         ZxazwPCP9QGXRTy/D2w8I7pZ0CJEwXBPsTEPewxOtZegukdlOLsrv1x21Y+4zxQftilz
         SuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGOU3ia6g6f+mcCeqoj5rUs2fETF3ERMMj8iqSjiOI4=;
        b=ottKrKoKA45P0LiCtkzJvzupwwVMPRtfFixdPt773nqqWX+L/7tlpFL50IwdhvAPSt
         JqcgsEZV3ZJ9UNe9iSxeuus+8KET4+sQPI4mJBCjFmIyZcqMkHQ0FmPnffk0F65UJySb
         jI3RoQepvjtgWJeDs80MJib+OxHDfPz0iiSZrDBUtk3iD7DJivnkiHVDQpZH5H5YFCdL
         9lJO+PWz0H3wGptl+ouWrdPpOmVnGM2wWyxsP4sSs6nXvWVeDse5rcEt7DIyZ3aYPyxd
         K3/Yr8GoosllnURi5uYGCojjhmHDlQ9u3nTzA+8yfi1Oy0Tx8DEkod4hdBzUZspdR8rm
         qD5w==
X-Gm-Message-State: APjAAAWIJ7BADDkdG3hL2knt+VSYbSy2wzl4KlrRQql4g0cZHR6fy9Rk
        nx2eeUSuojMQA2Yf21qd9Fe/9BvQv7c6vQ==
X-Google-Smtp-Source: APXvYqyys0p4vzH3+QBE8b2LeEy6eALBMG3KHgepXOv8RrEgFJw4q6sOt683Zhup+UYIuSsIl60E9Q==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr23877569wrv.224.1556133468924;
        Wed, 24 Apr 2019 12:17:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id s7sm3419954wrn.84.2019.04.24.12.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:48 -0700 (PDT)
Subject: [PATCH v2 5/9] drm/amdkfd: use helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" 
        <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Message-ID: <50613002-d5a2-2522-b183-4ab156686fce@gmail.com>
Date:   Wed, 24 Apr 2019 21:14:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2cb09e088..769dbc7be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1272,8 +1272,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
-	dev->node_props.location_id = PCI_DEVID(gpu->pdev->bus->number,
-		gpu->pdev->devfn);
+	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
 	dev->node_props.max_engine_clk_ccompute =
-- 
2.21.0


