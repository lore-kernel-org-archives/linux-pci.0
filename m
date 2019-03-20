Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C31C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ADA21841
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCTT5v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:57:51 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:40209 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfCTT5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 15:57:51 -0400
X-Greylist: delayed 1460 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 15:57:50 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 0D93840152F02
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2019 13:49:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6gxuhtUwu4FKp6gxuh79Yz; Wed, 20 Mar 2019 14:33:30 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=59762 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6gxt-003P2L-Dm; Wed, 20 Mar 2019 14:33:29 -0500
Subject: Re: [PATCH] PCI: Mark expected switch fall-throughs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kees Cook <keescook@chromium.org>
References: <20190320182715.GA9406@embeddedor>
 <20190320192454.GB251185@google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <f4bd4e6a-db87-8c21-fd22-f71652bdc14d@embeddedor.com>
Date:   Wed, 20 Mar 2019 14:33:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320192454.GB251185@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6gxt-003P2L-Dm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.104.39]:59762
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/20/19 2:24 PM, Bjorn Helgaas wrote:
> On Wed, Mar 20, 2019 at 01:27:15PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
> 
> Does this fix all the remaining cases in drivers/pci?  I'd like to fix
> them all at once.
> 

These are actually the last ones.

> What's the best way to watch for new warnings being added?  I fiddled
> with "make W=2" etc but it didn't seem useful.  Does the 0-day robot
> warn when -Wimplicit-fallthrough warnings are added?
> 

0-day robot doesn't know about these warnings yet.  But it certainly
will once we finally enable -Wimplicit-fallthrough.

Add this to your Makefile to see the warnings:

KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough=3,)

Thanks
--
Gustavo

> Bjorn
> 
>> This patch fixes the following warnings:
>>
>> drivers/pci/proc.c: In function ‘proc_bus_pci_ioctl’:
>> drivers/pci/proc.c:216:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (arch_can_pci_mmap_wc()) {
>>       ^
>> drivers/pci/proc.c:225:2: note: here
>>   default:
>>   ^~~~~~~
>>
>> drivers/pci/xen-pcifront.c: In function ‘pcifront_backend_changed’:
>> drivers/pci/xen-pcifront.c:1105:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (xdev->state == XenbusStateClosed)
>>       ^
>> drivers/pci/xen-pcifront.c:1108:2: note: here
>>   case XenbusStateClosing:
>>   ^~~~
>>
>> Notice that, in this particular case, the /* fall through */
>> comment is placed at the very bottom of the case statement,
>> which is what GCC is expecting to find.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/pci/proc.c         | 1 +
>>  drivers/pci/xen-pcifront.c | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>> index 6fa1627ce08d..445b51db75b0 100644
>> --- a/drivers/pci/proc.c
>> +++ b/drivers/pci/proc.c
>> @@ -222,6 +222,7 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
>>  		}
>>  		/* If arch decided it can't, fall through... */
>>  #endif /* HAVE_PCI_MMAP */
>> +		/* fall through */
>>  	default:
>>  		ret = -EINVAL;
>>  		break;
>> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
>> index eba6e33147a2..14cf0f41ecf0 100644
>> --- a/drivers/pci/xen-pcifront.c
>> +++ b/drivers/pci/xen-pcifront.c
>> @@ -1104,7 +1104,7 @@ static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
>>  	case XenbusStateClosed:
>>  		if (xdev->state == XenbusStateClosed)
>>  			break;
>> -		/* Missed the backend's CLOSING state -- fallthrough */
>> +		/* fall through - Missed the backend's CLOSING state. */
>>  	case XenbusStateClosing:
>>  		dev_warn(&xdev->dev, "backend going away!\n");
>>  		pcifront_try_disconnect(pdev);
>> -- 
>> 2.21.0
>>
