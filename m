Return-Path: <SRS0=oNFn=2K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514CC43603
	for <linux-pci@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE2624680
	for <linux-pci@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="JY0zJouV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLTMeJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:34:09 -0500
Received: from mx3.wp.pl ([212.77.101.10]:56436 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLTMeJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 07:34:09 -0500
X-Greylist: delayed 52558 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 07:34:07 EST
Received: (wp-smtpd smtp.wp.pl 20829 invoked from network); 20 Dec 2019 13:34:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1576845246; bh=kjcgqhlDm6IKEYAvFoc5PUa/xaCRwa7hKrTLEOb2brE=;
          h=Subject:To:Cc:From;
          b=JY0zJouVwXe0KyvOQkyMSSb8iMqEawDuQJNLRDQAIkhXLjDBN+ZLLGwByIb+U5pw0
           BusNxKmU6y3CFICmY+52lNL46gDBzR9IzTXAUBFNHyF8w4cBWAlwHxLxuQ6MuyhIX7
           9PA0BzBlw6zCma+2DdrP/ud16/XAuzV+Cj5z7Yms=
Received: from no-mans-land.m247.com (HELO me.smtp.wp.pl) (mszpak@wp.pl@[185.244.214.240])
          (envelope-sender <mszpak@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-pci@vger.kernel.org>; 20 Dec 2019 13:34:06 +0100
Subject: Re: [Nouveau] Tracking down severe regression in 5.3-rc4/5.4 for
 TU116 - assistance needed
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <c34a6fe1-80dd-a4db-c605-0a13c69e803f@wp.pl>
 <CAKb7UviSYORoeDm1sbDFEzkGd68+DV=StCpzsiaGbA=1VQX3gw@mail.gmail.com>
 <233aafa2-1474-39bf-8ea0-fe1a3ecef167@wp.pl>
 <CAKb7UvgOVrwC91ys19uTAG2p_MRVqcsV_MAHOSL4-m3f+j=dNg@mail.gmail.com>
 <68def665-d236-f3e0-7033-bcb9b9436d1c@wp.pl>
 <CAKb7Uvion7KuwgNaz0G3UD15nnkfM8hfayQgDtgz4d8W6p98bg@mail.gmail.com>
 <20191220060507.GQ2913417@lahna.fi.intel.com>
From:   =?UTF-8?Q?Marcin_Zaj=c4=85czkowski?= <mszpak@wp.pl>
Message-ID: <301efb37-43f9-bbc8-b4a3-b41291d660c9@wp.pl>
Date:   Fri, 20 Dec 2019 13:34:05 +0100
User-Agent: Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20191220060507.GQ2913417@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WP-MailID: 7071bb4f0c44cc4a89d90dc9e49fdef2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [MQJh]                               
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-12-20 07:05, Mika Westerberg wrote:
> On Thu, Dec 19, 2019 at 03:38:10PM -0500, Ilia Mirkin wrote:
>> Let's add Mika and Rafael, as they were responsible for that commit.
>> Mika/Rafael - any ideas? The commit in question is
>>
>> 0617bdede5114a0002298b12cd0ca2b0cfd0395d
> 
> This seems to be
> 
>   Revert "PCI: Add missing link delays required by the PCIe spec"
> 
> Can you try v5.5-rcX without any additional changes? It should include
> the same fix done bit differently (trying to avoid breaking systems
> which caused us to revert the previous one):
> 
>   4827d63891b6 PCI/PM: Add pcie_wait_for_link_delay()
>   ad9001f2f411 PCI/PM: Add missing link delays required by the PCIe spec

Thanks Mika, it looks very promising.
kernel-core-5.5.0-0.rc2.git0.1.fc32.x86_64 boots up without the
aforementioned errors and I can operate normally. I will play more with
5.5 before closing the issue, but at the moment it seems to be fixed.

Before I started digging which commits introduced regression I tested my
system with (then) latest stable kernel-5.4.2-300, but I see your
changes are only in the 5.5 line :).

Big thanks Ilia for your help to pinpoint the problematic commit.

Marcin
