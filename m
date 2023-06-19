Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2516BEB64D8
	for <linux-pci@archiver.kernel.org>; Mon, 19 Jun 2023 02:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFSCRd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 18 Jun 2023 22:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFSCRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 22:17:32 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4966E4C;
        Sun, 18 Jun 2023 19:17:29 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:35506.1764402843
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 2B4E01001CA;
        Mon, 19 Jun 2023 10:17:25 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id cbd68cba8c4f443bb65940078c2927dd for suijingfeng@loongson.cn;
        Mon, 19 Jun 2023 10:17:28 CST
X-Transaction-ID: cbd68cba8c4f443bb65940078c2927dd
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <827ede8b-b7b8-5aae-0816-244928b16897@189.cn>
Date:   Mon, 19 Jun 2023 10:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 2/8] PCI/VGA: Deal only with VGA class devices
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230613030151.216625-1-15330273260@189.cn>
 <20230613030151.216625-3-15330273260@189.cn>
 <dbf0d89f-717a-1f78-aef2-f30506751d4d@loongson.cn>
 <CADnq5_N6vVtzH6tzguZdHnP_TdRoG1G-Cr94O+X03jvtk=vhag@mail.gmail.com>
 <3c1c86ab-96ea-aa1c-c9c5-9a4012644fd6@loongson.cn>
 <CADnq5_Px-HWfwetv8LZsCnCeV7SMt_uqtLwMVK7648ZQiP2RCQ@mail.gmail.com>
 <f08b6a76-6c90-b59b-ff43-c779ef759d09@loongson.cn>
 <CADnq5_PFoM2O8mCd6+VFfu9Nc-Hg_HTnwEMxrq0FGRpva1kKiA@mail.gmail.com>
 <c2cdc3ca-20de-0133-b198-1118fcea7902@loongson.cn>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <c2cdc3ca-20de-0133-b198-1118fcea7902@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/18 20:11, Sui Jingfeng wrote:
> call back to use if successful


Call back to us if the drm device driver bound to the PCI GPU successfully

