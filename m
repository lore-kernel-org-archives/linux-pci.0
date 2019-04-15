Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C4C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 04:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEAB206B7
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 04:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SrtaYas6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfDOEkw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 00:40:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9444 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfDOEkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 00:40:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb40b500000>; Sun, 14 Apr 2019 21:40:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 14 Apr 2019 21:40:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 14 Apr 2019 21:40:51 -0700
Received: from [10.24.70.102] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 04:40:37 +0000
Subject: Re: [PATCH] pci: disable nv_msi_ht_cap_quirk_leaf quirk on non-x86 hw
To:     Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-tegra@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <CABr+WT=ANAs4DgvbfcgQ2wnX5yhT9HTgLJh1LE8Q09fyCa0mBg@mail.gmail.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <dfe14ced-294f-23bc-6998-3900a96f56ac@nvidia.com>
Date:   Mon, 15 Apr 2019 10:10:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABr+WT=ANAs4DgvbfcgQ2wnX5yhT9HTgLJh1LE8Q09fyCa0mBg@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555303248; bh=oH4qkDLhpeAkZd3qNtkcUIVi2l4kFSbhG7mIMcgrotI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=SrtaYas6SwnuZxk6/oOCHnLrcibgtrO8VHc9mXnbTQbvvEdJrKsIo6LJczHLMB1T4
         DvpvDyhcJwa2FSekZiNKgssvQqrHa4AqhnwB9JrMBsYqaEFuJGNo09h9HdG6bs0M+Q
         mSCtxuUTnqm3IL4kj8+BxFb0MKXFFRGQrNk9jeBFDF85/fdvNwrtd+ABKbp064GXwv
         XFfGQ8CfyI3Buy/1el1xe1A7jnVZ21Ou10xNxAMhjAE3f8RgjYTdNRIu3f9qUWUzxM
         KZ7SAZc/dJ75ThVf+gbASYK3VUfP+EWD1cOQ4eb1KSZmuUt4AvEUuv9YrHbvCIWyot
         oJd6Xt8CNVwpQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To: Bjorn and Lorenzo for review, CC: linux-pci@vger.kernel.org

Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Thierry,

We have similar change in down stream kernel, please review this patch and =
provide Ack.


Thanks,

Manikanta


On 29-Mar-19 3:15 PM, Nicolas Chauvet wrote:
> Le ven. 14 sept. 2018 =C3=A0 14:59, Nicolas Chauvet <kwizart@gmail.com> a=
 =C3=A9crit :
>> This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on non-x86
>> NVIDIA devices such as Tegra
>>
>> This fixes the following output:
>> "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
>> as experienced on a Trimslice device with pci host bridge enabled
>>
>> v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
> Any review for this change ?
> Thx in advances.
>
