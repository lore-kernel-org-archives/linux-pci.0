Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D74C433F5
	for <linux-pci@archiver.kernel.org>; Thu,  7 Apr 2022 00:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiDGAxO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Apr 2022 20:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiDGAxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 20:53:13 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 365BCAACAF;
        Wed,  6 Apr 2022 17:51:11 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Apr 2022 09:51:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2C9832058B50;
        Thu,  7 Apr 2022 09:51:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Apr 2022 09:51:10 +0900
Received: from [10.212.181.247] (unknown [10.212.181.247])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 66CDFB62B7;
        Thu,  7 Apr 2022 09:51:09 +0900 (JST)
Subject: Re: [PATCH 1/3] dt-bindings: PCI: designware-ep: Increase maxItems of
 reg and reg-names
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1649145062-29833-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145062-29833-2-git-send-email-hayashi.kunihiko@socionext.com>
 <Yk3YaAWPJ0bpLTHK@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <b7cd4fe0-5d61-322a-b42a-d239ee23b201@socionext.com>
Date:   Thu, 7 Apr 2022 09:51:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Yk3YaAWPJ0bpLTHK@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,
Thank you for pointing out.

On 2022/04/07 3:14, Rob Herring wrote:
> On Tue, Apr 05, 2022 at 04:51:00PM +0900, Kunihiko Hayashi wrote:
>> UniPhier PCIe EP controller has 5 register mappings (dbi, dbi2, link,
>> config and atu), so maxItems of "reg" and "reg-names" should allow 5.
> 
> Shouldn't that be 'addr_space' rather than 'config'? IIRC, 'config' is
> only for the host.

Yes. I made a mistake in the comment.
UniPhier EP controller has also "addr_space", not "config".
I'll fix it next.

Thank you,

---
Best Regards
Kunihiko Hayashi
