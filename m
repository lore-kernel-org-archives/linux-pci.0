Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9DCC10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047092073F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDOL4C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:56:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOL4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:56:02 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6bsM-1gmt3Y0p4w-017zxB; Mon, 15 Apr 2019 13:55:50 +0200
Subject: Re: Device Description for FPGA Components on x86 system
To:     Alan Tull <atull@kernel.org>, Federico Vaga <federico.vaga@cern.ch>
Cc:     Eric Schwarz <eas@sw-optimization.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-x86_64@vger.kernel.org,
        linux-fpga-owner@vger.kernel.org
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614>
 <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
 <31100498.IIhqzTXyFT@pcbe13614>
 <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <08e60e79-8ae3-06ac-779e-d4d99e0ed846@metux.net>
Date:   Mon, 15 Apr 2019 13:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bzbLUuB/S1gkl4iCuqnMSQ6iuv/Z3XXNhKYeb56yD4ogPlwH23o
 wwTrrOQNiLN7mZJmlsM51zu9ft8g2qwll2UVuiKMc6yCxRnBdLz0hLIocFxUcwdC07VIp/v
 s2mj9HuL6oNdc+xTU0F1hwb3RiNZZ+B+D+CS0++wKB6zQLKIhx7dlBRoBQ1+RkrxJAjGUGE
 j3CvRIyIahGNP+KZn6KgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTH253luN0I=:nZ6l8jhyqfBShxUbfJkYD6
 wsFZIuNj8zb+T66yRVC9jwsrRPi34SibAE8cmakCVGvlY/bpNBiJDB6nHmD4repdmCNi8GBJl
 ScvmDxp0rOt6yR4ms/RruCx1ypmORECWAtbBG6f4uhRL7K6PHG4C7EugcfjSdPc0lF947zBf8
 Ts2n/tBLFO/lTl9yl5V/KKKY5c1kOngfaNfeuNJHHq7muDt8KGkioXgBHAK+KwbJstJWAblAC
 gnXQf/krdMpnxvSZgb2fCfNC9WieffpeV2OHuU3Bqdnyw4LKa9sxm6ZteQtUWNg2D+b/Y0F/n
 hGEF5vnXuTEeqJsxiZHhi18TKZTHP223VlhPaJrouq5vwNU1W8eJooneq2vIQHu3Pwg9UVxIh
 2MPoy1K4xBZpy9Pr5VM7vMAvCLKlh6IifcuffUoEpbxdVvWiLLtatktm3L/fdvraEBsfA2zFy
 XOakwS8hT6FGEDFwq4h0UGUtim0cfePPrMykJWz88yleQm5F9VfiM7T4ryiT8uuFEQDSEeXS3
 bFrCcW3fwTU5+L8bdViMEe/xRrgYhMphHFWol5T4ddf5tQ9TzyIJQjUDaqAwhffXqDrbtYboq
 jgoTFYmzSea8D5BfjaOGm/pbz5wdVo4saIkN3W9KKQcShl7HBXTDtP9xz9PbvAQ7/L/aFXd8N
 8T3R9Y85yCtbRc80bRTYhGU2QhpHiF7Qb3nRHpOjcXYbnZNJTcr28i0qSqpspmN2ktyX2TQ40
 SKyeEzU/u5tEvaI9Wdg6NVPr5xOQ1/c7elUBAyAfc4hdOs+Sc1LdEx2KB/s=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10.04.19 16:21, Alan Tull wrote:

> I wish I could point you to a complete solution, but there is a lot of> work to be done in this area.  Most of what is in the kernel is a low>
level in-kernel API [4].  As you correctly state, the hardest part of>
this is doing the enumerating if you are on x86 and aren't using>
devicetree.
ACK. I believe, introducing oftree the right way to go. I've got that
on my 2do list, too, but yet too busy w/ other things. So, if you'd
like to work on that, I'd highly appreciate that.

I'd like to also use oftree overlays for some platform drivers that
essentially just initialize/wire up generic drivers to perform some
board specific function (eg. drivers/platform/x86/pcengines-apuv2.c).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
