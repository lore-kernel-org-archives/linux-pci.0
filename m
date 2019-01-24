Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CAC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4513E218D2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548353910;
	bh=ZMQksBnxGnwTw4zpE/Hr2u4GQO3dSNtgcl3zn6+bOnw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oGHPoAEWJnjF2Q01aL3yrmw3siavb9V3MvLEOB7zuENSRgpAwattGFL/SUfSASS8p
	 xQK3iLjj2zAiq+NLdEYN/Ld+CvhbAP4Zazh9WpeMKJoZe/XiIqWABkdVUplCdGK3uJ
	 FPHGrNELfLHVaa42AuAJspXvjf5I9+dfARe5tGHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfAXSS3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfAXSS2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 13:18:28 -0500
Received: from [10.84.151.11] (unknown [167.220.149.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C0E8218AF;
        Thu, 24 Jan 2019 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548353908;
        bh=ZMQksBnxGnwTw4zpE/Hr2u4GQO3dSNtgcl3zn6+bOnw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=twqho3sFTszEMHLkHI3z/zs3Xk+U0b63kBnrJofmOcA4/qxwraP3oPXEXRDpNL7Rs
         7KUDuwYJU1xQGR4lobszJjUsC6llQgSqURjVSHTR/3BFg3V38VTIqC0047WCG/XsBn
         ehXx2n5qS1fxjgyHyHPq0KXXrppmlg5lXg03c4f0=
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org,
        keith.busch@intel.com
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
Date:   Thu, 24 Jan 2019 13:18:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/2019 8:50 AM, Dongdong Liu wrote:
> The patch [1] PCI/ERR: Run error recovery callbacks for all affected
> devices have broken the non-fatal error handling logic in patch [2].
> For non-fatal error, link is reliable, so no need to reset link,
> handle non-fatal error for all subordinates seems incorrect.
> Restore the non-fatal errors process logic.
> 
> [1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfcb79fca19d267712e425af1dd48812c40dec0c
> 
> [2] PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=86acc790717fb60fb51ea3095084e331d8711c74
> 
> Fixes: bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all affected devices")
> Reported-by: Xiaofei Tan<tanxiaofei@huawei.com>
> Signed-off-by: Dongdong Liu<liudongdong3@huawei.com>
> Cc: Keith Busch<keith.busch@intel.com>
> Cc: Bjorn Helgaas<bhelgaas@google.com>


According to what I see in the code, link will be reset only if the AER
severity is AER_FATAL.

	} else if (info->severity == AER_NONFATAL)
		pcie_do_recovery(dev, pci_channel_io_normal,
				 PCIE_PORT_SERVICE_AER);
	else if (info->severity == AER_FATAL)
		pcie_do_recovery(dev, pci_channel_io_frozen,
				 PCIE_PORT_SERVICE_AER);

Can you show the path where it leads to link reset and severity is AER_NONFATAL?
