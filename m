Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590FC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073AB20870
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480843;
	bh=PDLjyvRfE0cemEu05PQ0ksV3VLEv5Q1ohXJAdlKLAZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ayivXxR/avTCM33zbpdTmqGtIZZysO8nN5TOTBjYaq9i/UzrqrSmatHQ7cxxUZvEn
	 IP++X8FSTofqjtTmCglecCfeBORmkz7xM1bvTz6HEwpsXWwBSjZ0KNGbZI+JEna0uC
	 851ihRtlqelxtxAHx3p6l/5sU+2UQ1J0GxJew2Mk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073AB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeLJW1W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:27:22 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41771 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJW1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 17:27:21 -0500
Received: by mail-ot1-f41.google.com with SMTP id u16so12062258otk.8;
        Mon, 10 Dec 2018 14:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvRhIVVhr/cozyJX9RAjS/CB+7fBgUA/l3WWhv0euSk=;
        b=FjaLypW/I7BVPbK7wZ1Qalvoj/VIg4D2ZToxXFa+MuNTRaaHlzOzSDid/5CQyCYAkn
         lI1fNWncyb49TPBp4SaFZTSKrVgPGdCKrKPD8XhjSYWWt0P8YOFcGSvhS/aaV/eON93i
         OGdGqMQgwRb+N//MYEoHS+ixlbI95cYu3gqcdY8TdjH1+UIjOLuLIcWJRQvGs2opGqju
         3Ai4nJk6ud6qJwZ4rGEyrjqUYex6R4C3eHO43fcIO0lxHNhrrSFKTCHrhcI+Nkne1t6L
         jl6zYY+yhIZmhveqM9f3vdRkjqw00JOTpNA7sFSOWTDlfiq2j6HbfRb5NY8onSIFUxnJ
         CKRQ==
X-Gm-Message-State: AA+aEWYaJKUyN4rpL7Y98UW0ijpbj+CEy23sHNYlo34Vk3X2NHTTzNdi
        iR4dY1KLP5ECxMSYnbYRbw==
X-Google-Smtp-Source: AFSGD/UddJoUUe90aa225QLWVvx6jXXsrkNO0JvtpOE/jl2a4WMPME28Jfk11g9sdE5mSwnpMhleLA==
X-Received: by 2002:a9d:3208:: with SMTP id t8mr9630444otc.312.1544480841066;
        Mon, 10 Dec 2018 14:27:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm9097817oia.55.2018.12.10.14.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:27:20 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:27:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv3 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20181210222719.GA6506@bogus>
References: <20181203103505.46885-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203103505.46885-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  3 Dec 2018 18:35:02 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
