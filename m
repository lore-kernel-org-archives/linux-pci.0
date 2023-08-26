Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7D6C83F01
	for <linux-pci@archiver.kernel.org>; Sat, 26 Aug 2023 15:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHZPja (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Aug 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHZPi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 11:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF9199F
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 08:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A822A60B9B
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 15:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E4FC433C7;
        Sat, 26 Aug 2023 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064336;
        bh=AhHOE+P4JxMBh24kPTGMBSIjODF9G+hVoKWd0iLMDb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5I/QpkZpUHIadlb9K4ekM1osqMox8ACZMZM8NdOhpFkhMHe8RD5OpWahZ7dlzYI4
         YbRb8mpdXi2IklJDm46leDrznZcIEX4e4dyLeg1q8lp9zoCW3LFNLCqAnuYC2edZ0e
         O0weZIK8cQAcQEutUMXWOACeqgbSnrXOXKLPo181m6sE3FKg2d8r8XaNrLFrse+Ep6
         E5GxEwJuKsxnUq0mDBAAyGH4dj7z040ZjQTstDWdV6FL90FgcIlOm7ZTiy2xhHkuRi
         KF2s2lvz7y4jaEqDISmAdOnq8nrzDDHo5SjK11i0ajDXy0SBf3yVP4hO/3IGCebWfo
         RHLQKT7EuaZjw==
Date:   Sun, 27 Aug 2023 00:38:54 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [pci:controller/qcom-edma 2/7] ERROR: modpost: "__umoddi3"
 [drivers/pci/endpoint/functions/pci-epf-mhi.ko] undefined!
Message-ID: <20230826153854.GB774351@rocinante>
References: <202308260652.rZm0oJCE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308260652.rZm0oJCE-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> >> ERROR: modpost: "__umoddi3" [drivers/pci/endpoint/functions/pci-epf-mhi.ko] undefined!

I will take care of this on Manivannan's behalf.

	Krzysztof
