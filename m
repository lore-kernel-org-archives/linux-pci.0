Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C34CC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F390B218B0
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556104366;
	bh=6SczV3J26SgKz5Chft/TaqeJuQhMvIXUL4P9CNUwETI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IzoZMA8Mf3JtLcUtrV6wif41ADOOiv4z55pgP/da7cvjDYUqO/kvWAbZ0hdWKBqlQ
	 gN9ANWm0+wJT8XgxYUHXCEag8u45Oo49xqSyzSODFDdNNHf597wNLoD+NnQtLznGxE
	 NeVNg6/hAk+Ubh7Gg1LENBgBaEpvHiA7Qd04vJeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfDXLMp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:12:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44276 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfDXLMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 07:12:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so15688075wrs.11;
        Wed, 24 Apr 2019 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsnkTCn3YR6sKqzaA2z1fVyvthO5dOiyjShuxgSE03Q=;
        b=na7F1JMRVgatNhwECvNERBeuRij/6w7hH26Ie04Wncqe3beGoJqYXrmuW254o6HRly
         4vlAMTRgb54wXkABrbGD5N2iWisV4L8tRU65Z0IroK5D7N+eoNxf4srrayuHjrDYh6GB
         WB0IDYYJ1rei6qiOY9SMtxjWKcrbEoG+WYVF4r7WKwMGiGNIAQZTbwzIJI8IsEZ6B1ws
         X/BT/o9plzJKVRDbFi6z3iI3KP1DuVOSuOiDaugfh3vRKI+yUZ46xWl3hUsMF6Q/u1qM
         0zyyDpTN8xDHINDPSK2Pr55h43eTJyUxxk9mqXdff2Sc439OBB4exiTPtAcjlLOAO3aY
         H8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsnkTCn3YR6sKqzaA2z1fVyvthO5dOiyjShuxgSE03Q=;
        b=NpK6J0NjVUp4yu0EFfAdJFkbMaFAgwMITI9JlB+Ed29ddSNxRhr8RmWOx3T9DTuoYS
         0syCvUd60If3QtALQCHXZs3aXIzDitqy1w7oX3pL1ct91yMnOm7YcHI1IfJg6dytcANJ
         5rFCipYFP0NFH1wIAeEKw3zv1CR8ak5jaAZqerMHIfkqmUVgl8MzTbL0fgOpV3ADKcuU
         BMPs1h9GL1RuaCww5HB8KDA8hMxJ6d0O6HuidFnIaRBQDRNXYnRYDKKyQjXxzLa7jB1P
         ggLlr7IruB0xOPASjVpkyUvDU8NSqcf9OqVLj6pCUoAuQGmg28l69vURyuNhnTce1b54
         DGtA==
X-Gm-Message-State: APjAAAXlVon8k3jEZHoUbi2dZG0/vPcNdRA4TrQn4Xpg+m/JTzHEjute
        4lQfoE404KTBoXVYLpEADh6V7671
X-Google-Smtp-Source: APXvYqyAXX8yuVSFGEsaPAAir+Dw/WedxklSITKOlI8rOQweUMniC6OBMcloXIo2PWsGAdoyjkvIjQ==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr21557598wrg.146.1556104363617;
        Wed, 24 Apr 2019 04:12:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e7sm15715054wme.37.2019.04.24.04.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 04:12:42 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:12:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190424111240.GA104443@gmail.com>
References: <20190410080220.21705-1-hch@lst.de>
 <20190410080220.21705-3-hch@lst.de>
 <20190410081617.GA54229@gmail.com>
 <20190410214500.GK256045@google.com>
 <20190411051849.GA26205@lst.de>
 <20190411133543.GO256045@google.com>
 <20190424053806.GA12136@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424053806.GA12136@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Is anyone going to pick this patch up?

Sure, I've picked it up with Bjorn's Acked-by and will push it out after 
a bit of testing.

Thanks,

	Ingo
