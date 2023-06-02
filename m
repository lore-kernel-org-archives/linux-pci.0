Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3745C7EE2C
	for <linux-pci@archiver.kernel.org>; Fri,  2 Jun 2023 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjFBMOi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjFBMOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 08:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168F1A8;
        Fri,  2 Jun 2023 05:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF87F64E79;
        Fri,  2 Jun 2023 12:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F55C433EF;
        Fri,  2 Jun 2023 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708074;
        bh=fv+aYyf2scmCCse0GQ96VR/s1mZx7PcHfoE26SDY45o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W21RN1Uxxq7mutev66WMbKB707GEzl1xnO9rDZEL3IMQLDJafurIsyhooMAe/ZCb9
         SCSKUdx6JLVDzE5CdS/J2CDcry8/3u/yrEwTOUEPH+yRx6GqDuGrkd0p3lnVUwRX5i
         Bzn1k79bjnMn0eDsV3FuHZ1k/AVHFwv2dNBJYYDSqlNB8bkfY5wWCR8YvR4O9EYkwM
         XoDbCOz13Q1DBa8j4Dzilb2Sq5PS+YjM+QoAP03bRfOk2kaowa2mkTEhSBURixx6GX
         IcwGWs3RXQQqI/tnj0hZcxS8Bzadl6UOHprZMikXXoFIIsYkahRzSCvcUDgrC4fXfX
         ovcHrYy/xwyfg==
Message-ID: <7061ec06-2929-b59c-8b60-5b2fe926eb5a@kernel.org>
Date:   Fri, 2 Jun 2023 21:14:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/9] PCI: endpoint: Return error if EPC is
 started/stopped multiple times
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-4-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230602114756.36586-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/2/23 20:47, Manivannan Sadhasivam wrote:
> When the EPC is started or stopped multiple times from configfs, just
> return -EALREADY. There is no need to call the EPC start/stop functions
> in those cases.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

