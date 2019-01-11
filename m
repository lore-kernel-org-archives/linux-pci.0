Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F4C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DC22133F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218755;
	bh=964eseWC+a5uNB5Bz8quszPDxhHTwysLcQtKrQLjIHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXAMnk7mvPCiod8w/Ud3qA6WOFy07YyoOq/fRDQfLy3Nt/rEZTfn9feJEP7HSHjTW
	 wUVoIw26xJ5Os2Qqv+EGbWghfssf1JRlkUqDRbaZgKn6IhnQbAeZDktDDw8uaBb0fV
	 /typn2ZwYMDC21JA9jI1thF6FX8y2E6xDlsGhDaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfAKO7I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:59:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37465 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfAKO7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 09:59:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so4830118otq.4;
        Fri, 11 Jan 2019 06:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DEiE0eIWL0l52ydQkBLYPcSEvU6l2DyGvvRi/3/8IPk=;
        b=CKIUnlV3rrp6bZDEcEvrXvjxN0ZMHRBj4LgsA8y55n3yCqOO7cJGxlZmQplVDMbY/L
         m+guzOoZPQ/zF/X/0GGp7AgWoUuKGWRILDtTqVrPbscNXd90ZVBWi0d05w6dg2hjqpQN
         JCUvwHTVFbUwsXCjcwSgn44frg1WyX1POvL0Y/NWpfDBMAMzsYDvHbLTw00qigIUlWoD
         0t01O9rmo/P63FkjVEN1lU1I4TsCwZKhKaz4mEiDLpjF+OTm1TJgC6lR6IJ7rk+HEaXy
         JCIP60dr/gP3PlGfOBW3TbuNe7aeHIhRNGhoh/9a1R8LeLEGhnh+02zEOZ+5hWzBT2VY
         5c3A==
X-Gm-Message-State: AJcUukevZUAs7wX+3zxvD6f74BZmsB8i7uStF1Cw7dpu6FYUICqxmzFu
        YXFgIkVHNgfE7l62P1d89Q==
X-Google-Smtp-Source: ALg8bN4O7gK3lpkKCyIQNbgyjf7eQe0KJylqNMvLXQkuVV1pz1b0Y4gGIta4cvdqp3dJM9WkFZyIuQ==
X-Received: by 2002:a9d:6f0b:: with SMTP id n11mr9161006otq.363.1547218747249;
        Fri, 11 Jan 2019 06:59:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b2sm10744632oia.8.2019.01.11.06.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:59:06 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:59:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: PCI: altera: Add
 altr,pcie-root-port-2.0
Message-ID: <20190111145906.GA1299@bogus>
References: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
 <1546409810-37630-3-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546409810-37630-3-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed,  2 Jan 2019 14:16:49 +0800, Ley Foon Tan wrote:
> Add support for altr,pcie-root-port-2.0.
> 
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  .../devicetree/bindings/pci/altera-pcie.txt        |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
