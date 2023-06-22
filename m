Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B2CEB64D8
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jun 2023 08:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFVIuR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjFVItx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 04:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9BFE
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 01:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65E161768
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 08:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C356C433C0;
        Thu, 22 Jun 2023 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687423792;
        bh=fd3ocUb1brB9aPpGQuEtpnBKK7pjWMF2CQeU7fP6FoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PSGFA5jA0ahlNnMMZAKlmWfY94UJaSdAl2kRNzJi/w7N06KiRMRTMyEV0bKEKo+tF
         r5kfYNKnSRxjB8+LH/sQaiSR2YSqDpFxkNIbLYl6YQ27ATy/zOfU27vlfDQDNLfteE
         yelnuFE1hAO7jbOEqISlikymfYbC1HkiOEPSXBal0nO5HeZVhAb1OCVG8s+aN/nE5U
         fwiKqmpLg4DggHpH751XBELES9Bd32Ts37/LZB3dT0zjLvesch9xkqeYNccM2KwVVY
         ZtBCv60qC5qdnxzqETX1kDuwr8aa2B9OikH3ZvfhSRSb7n/i9jYW9CzBT5GhPNxRlt
         0dGvhB2/LmC6g==
Message-ID: <fafe4e52-731f-46b8-971f-afaa64f182d3@kernel.org>
Date:   Thu, 22 Jun 2023 17:49:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Rockchip fixes
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <d023a76f-93af-4112-7020-d888bb8a0ee3@kernel.org>
 <ZJP7Udy5naEPinhq@lpieralisi>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZJP7Udy5naEPinhq@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/23 16:42, Lorenzo Pieralisi wrote:
> On Thu, Jun 22, 2023 at 01:58:35PM +0900, Damien Le Moal wrote:
>> Bjorn,
>>
>> I still do not see Rick's series queued in pci/next to fix the Rockchip endpoint
>> driver...
>>
>> https://lore.kernel.org/linux-pci/20230418074700.1083505-1-rick.wertenbroek@gmail.com/
>>
>> Did this one fall through the cracks ? It was posted and fully reviewed last
>> cycle. Really need that one upstream.
> 
> I wrongly delegated it to Krzysztof in patchwork so it went back to his
> patch queue, my bad.
> 
> Now pulled, thanks.

Thanks !


-- 
Damien Le Moal
Western Digital Research

