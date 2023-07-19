Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6468C001B0
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jul 2023 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGSWoz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGSWox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 18:44:53 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683F1FF9
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 15:44:52 -0700 (PDT)
Message-ID: <74994ce2-c060-f662-9210-14d09a15162f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689806688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjbO79xlLNloGHqzkmh/GrwE5dqq196RqzVZxz+HQuY=;
        b=tyL+5EjVO88fUgTXUzZJvKY+JfMezNTNqLlky4Key7ELBF1/bJEXZwIzwfXEU5giFkbOHo
        bs2sLXFvTbu5KRkClnah41uJLYUoPnho/GiocT6aPhwta72XhksZVZ/iUoXF/ZG9ZHo7Cc
        K41KgUorxkZsDqez3UfEW48aM4qvmjI=
Date:   Thu, 20 Jul 2023 06:44:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/9] PCI/VGA: Improve the default VGA device selection
Content-Language: en-US
To:     suijingfeng <suijingfeng@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
References: <20230719193233.GA511659@bhelgaas>
 <f87a48c6-909e-39ba-62b0-289e78798540@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <f87a48c6-909e-39ba-62b0-289e78798540@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/7/20 06:32, suijingfeng wrote:
> it will be works no matter CONFIG_DRM_AST=m or CONFIG_DRM_AST=y


It will be works regardless of CONFIG_DRM_AST=m or CONFIG_DRM_AST=y.

When vgaarb call to the device driver, device driver already loaded 
successfully.

and the PCI(e) device emulation already finished.


So the last change the vgaarb gave us to override is actually happen 
very late.

But it will be happen as long as the device driver get loaded successfully.


