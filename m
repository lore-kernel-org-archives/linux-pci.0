Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA8C10F14
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA7C20872
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555466269;
	bh=UHOASpbytNN0B/0PrJBY0fowtW4dZ7jCVEKLOelebK4=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=H0vfICz0zoVdefIvPNyib80LpEtGAlYBiVSe6dDDSoSdeBrTBGeqEE0lRXZVGHBqR
	 3a84c+iZsNiUaFcAFfPEvhO/cJiIErAXtVp0ytXLwcIWoIEtOCkSQ4An1AWVPJPwf9
	 rB9rEvi7wxud0gW07/PvSyWXafAKE7hcXYx8kqP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfDQB5t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:57:49 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42852 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQB5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 21:57:48 -0400
Received: by mail-oi1-f181.google.com with SMTP id w139so18699791oie.9
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpXLGubjG2+El4Nd7r/uFe39LzN74ViArBcEjhGG5MY=;
        b=oNKQHqLGndyg1xMyH3H8UYz0QpM49Vm5rkRfRsHnUwKyOHEioTSCnHkYbxEpnYQ/Ft
         Q5sreN/3mXQ9Yc+mMtqhjm2gMIz9DvvpxJRstPPL2Wg/UClQrckkqiaYxSAz4VXik4eG
         YRz3Lsvq4feqbD81Xp/1v9zmY92pRqyhJ2QcRT+1mrtPaf8K7aGWDp/7UL3x2YNvd2Ho
         eWCXEFCy8uF3zh+hkU/QPicJxqe6JC42a17X2yzYMdmLZW146Cm+cnb6QpAmgWUnGIqC
         /kBBY0D2ArqOHFBbvFVbMhVJ3efg63siv3UNTf8i3J7t/snoEi/zgPUOW38oaObPRBFf
         cqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpXLGubjG2+El4Nd7r/uFe39LzN74ViArBcEjhGG5MY=;
        b=fuMStxYlfVuR24RS5xsCCZTT1EQxTW3yIi0mVi7zWpnUs3ge/hrHm3kZimtl4NpVTq
         6mGUlMN5zGh3mZrarncP9+n5utzVL8ilX6g9qoT0EvSybYlsWGLWq5CmNgR9TCv27SoO
         4OXXEZx+/U0gl4WyaOsIsNJ3UL/vQ8WlERGsSO9vP2D3Ej1UOrOfN4X8y+DqE/mW9azZ
         KARfknKU3ZwwxEVzUy10TYH9PEfNl+08VeS62+CKP9jk9gXtdkQ9fTS8ECYsjkSQrQGq
         kPUV4xWjgwyg7QenS53jZfDXDXqxvC5FSVpITVX3+/lGYjdEjMC5EZawKZBpeJCY3VgY
         nFyw==
X-Gm-Message-State: APjAAAWK04z+BWt8lEpFrP+eF9VFcQk2ssGKHPTHRRr7ccmLX+MPqVbP
        egPw3gUEb5WXCDa34QnOAag=
X-Google-Smtp-Source: APXvYqz0YQ+p5lO15wPmlZHld5kK1xSoukSZn+iUMLWZsxqqzTATUK5CX3gf6jP8RyQ89FNkqt0fcg==
X-Received: by 2002:aca:3289:: with SMTP id y131mr18882101oiy.42.1555466267937;
        Tue, 16 Apr 2019 18:57:47 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id h23sm24933571oic.10.2019.04.16.18.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 18:57:47 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: Linux pci card forcing a remove and restore
To:     Scott Branden <scott.branden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com>
Message-ID: <5faecb36-a594-0d0f-3ac4-14a502cabf81@kernel.org>
Date:   Tue, 16 Apr 2019 21:57:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/16/2019 7:34 PM, Scott Branden wrote:
> But, is it possible to do this inside the kernel device driver after it 
> has downloaded the new firmware instead?

the Intel's infiniband driver is doing the same thing.

https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/hw/hfi1/pcie.c#L872

