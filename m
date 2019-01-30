Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD9C282D9
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CD12086C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548874170;
	bh=ixLWY9OVlE2HgOEa9bPSIYM5P4xklubm8XlVhQdcftI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QgJH0pZeaHMfXbYSrD8Dih7EimV+jiiNYGiQrjBrzKOMWt06WVezFydJsgFD8DIFk
	 acrHPgJSxYt4v56dZpCdVIUu+o8A9AKyvO4zZrWlMAJ7O5OO5p4+73DD6DOKTRGNAV
	 l8hG1HRU0nZWvZDn1Et7d/Ubo+Xe8hUb2S/7YrYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfA3StY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:49:24 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37192 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfA3StY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 13:49:24 -0500
Received: by mail-ot1-f41.google.com with SMTP id s13so545489otq.4;
        Wed, 30 Jan 2019 10:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYYlhSahpUNu07gio0txRqogQXhjXBtvhFKl/XrSWBY=;
        b=SEYQwni8HqlSUUxB3WFU03R2wQgGy5qh4WWchMkEw4pG3z8roBbvgiVpEnmSsOwkkY
         fL7xvgpwiLsPAfQOIRLHnkF94+iwtJ3TO3yTdNlGLbJnAkv1WsoIZmlPLrzKa2oQWtCe
         YzchvcqIwjTuJOU9acS/iGhMobJrt8jeUsB2VoJiFfZ3hEpX3anBgfuvxbWc6GkhJUfn
         tUnQkyYtmbVwGEAZ5qDaH3INj7QbwOwdil/szVsNZlHu0pCkdKs0fVAhkXwuf9lKhUVf
         csxIv2YG3r5Xp0DrjcVYuhoh6oIeuiF1vZ3Qsrdd6aw35rZ6OzD+oOzfxJjlJ7C2jKaW
         WGHw==
X-Gm-Message-State: AJcUukdNqReSy7vvkWkUzhlTsCFTZ4J320JksuIcbuZ6aw6iM+QzlgKj
        67eLB1Yy1RbZlQ7o3kA7zQ==
X-Google-Smtp-Source: ALg8bN54bW836SloDXShRDMPNqN03yId2mioatzz5oGhCooWcTX9jq6BWbBL79OHo+A7V8eZwjdtWw==
X-Received: by 2002:a9d:177:: with SMTP id 110mr23986512otu.26.1548874163431;
        Wed, 30 Jan 2019 10:49:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm795044otl.4.2019.01.30.10.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:49:22 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:49:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv3 22/27] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4  controller
Message-ID: <20190130184922.GA13423@bogus>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-23-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129080926.36773-23-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jan 2019 08:10:49 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Change back to use an new doc for Layerscape PCIe Gen4 DT bindings.
>  - Switch the order of "csr_axi_slave" and "config_axi_slave".
> 
>  .../bindings/pci/layerscape-pci-gen4.txt      | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
