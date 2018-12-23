Return-Path: <SRS0=b3zO=PA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75CC43387
	for <linux-pci@archiver.kernel.org>; Sun, 23 Dec 2018 23:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653A9218D2
	for <linux-pci@archiver.kernel.org>; Sun, 23 Dec 2018 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545606797;
	bh=qE3Rqatxs4Sb9UpsOGX9jphUXDhPhh1LRiAJ3UuhhYg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=p4uoGrwcHXRWSHXKa8EoaQF3csjH4t/MI2s1Uo+q/9e0pZ95rhWxPl6BZ3uNL7alJ
	 IFQDWK8JjuxnIi+wA/GxI114gUEoEYEIPg9ppfGZYPw9OsbRhFC42REBQh6L8dC2mz
	 JSM1o2Y506+dwM0rYIsBQ93QHczrxqifzlm3B2OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeLWXNQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeLWXNQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Dec 2018 18:13:16 -0500
Received: from [192.168.1.25] (unknown [195.142.208.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55212184D;
        Sun, 23 Dec 2018 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545606795;
        bh=qE3Rqatxs4Sb9UpsOGX9jphUXDhPhh1LRiAJ3UuhhYg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J0NrYayKC794ooh71Dv6snrVTctpM4OC9Z5U9i/AIsEs7YXxASamGQ2QOBDsxGLyh
         ZAmDv2BemR6juZSGs/xl3hVahbNzOKUwKGI8Ugs97QuIaIF0lp8fMs+X+Q2RVop65h
         KvRN0j0z5cH9Xe3Hu1sAbN/uXI1KPgcvFCIDiEdg=
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de>
 <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
 <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <7e3c5fa9-bd21-bb1f-f668-77d55a72d40a@kernel.org>
Date:   Mon, 24 Dec 2018 02:13:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/23/2018 8:15 PM, Lukas Wunner wrote:
> On Sun, Dec 23, 2018 at 02:00:15AM +0300, Sinan Kaya wrote:
>> On Sat, Dec 22, 2018 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
>>> On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
>>>> This driver depends on the PCI infrastructure but the dependency has not
>>>> been explicitly called out.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>>>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>>
>>> This series doesn't have a cover letter so it's unclear to me through
>>> which tree it's supposed to go in?  Each patch through the individual
>>> subsystem tree or all through the same tree?  If the former I guess I
>>> could push this to drm-misc...
>>
>> Feel free to apply individual patches independently. Let me know which
>> one you applied so that I can drop them on the next rev.
> 
> I've realized only now that this patch fixes fallout of commit
> 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> which is part of Rafael's acpi pull for v4.21.
> 
> Usually such fixes go through the same tree as the offending commit,
> so I'd expect Raphael to pick up the whole series and forward it to
> Linus in the second half of the merge window.  I'm not sure if that's
> how it'll play out though given the holidays.

I'll do follow-up with Rafael. Apologize for not giving the full story.
Trying to get pieces out in the middle of vacation as there was a breakage.
I didn't have time to polish.

