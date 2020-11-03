Return-Path: <SRS0=8M4G=EJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F3C388F7
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 22:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9002242B
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604443059;
	bh=alGO7l081fbLxENgyUANQp2DJKzDlClpHItGzHVenpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=G8pPikQKrAOdJziPaJpvlKiShxXE61OsxOuM050f52Yr0bPAlf2J8Crl9kU/QHroj
	 MZnCyVSIWUOcYSZu/EuavefRu3k2XU0QxyChKlwvxhIFMFHe5rzu2spoL0B8e2UlY7
	 24B8CDJOQBvJ+VeIgxBjuWHZCyPlmUVEEjNoIvmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgKCWhi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgKCWhi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:37:38 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8CD223C6;
        Tue,  3 Nov 2020 22:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604443058;
        bh=alGO7l081fbLxENgyUANQp2DJKzDlClpHItGzHVenpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BNG78IeCTtKTR9mC8s7C6PJdRxVBP8JQhM8VBKQ9udqSn56aae9EeAx5IeiH3n3MQ
         reVqUActE6b/2phX9L5Jl5KoCidj/Rfb9+EeKWbr8DF4KuD9rI7/r70Vod8OSP0XEN
         UsoIbRERVWFFmKfLGyIZd2Tmnf2TcxokCQld4sAk=
Date:   Tue, 3 Nov 2020 16:37:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dt-bindings: pci: rcar-pci-host: convert bindings
 to json-schema
Message-ID: <20201103223736.GA271290@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please follow the subject line convention, e.g.,

  dt-bindings: PCI: rcar-pci-host: Convert ...
  dt-bindings: PCI: rcar-pci-host: Document ...

On Fri, Oct 30, 2020 at 02:29:02PM +0900, Yoshihiro Shimoda wrote:
> Convert bindings of rcar-pci.txt to json-schema.
> 
> Changes from v1:
>  - In patch 1/3
>  -- Fix indentation which yamllint detects.
>  -- Fix typo which checkpatch.pl detects.
>  -- Add ref: pci-bus.yaml
>  -- Remove some properties which the pci-bus.yaml defines.
>  -- Use unevaluatedProperties instead of additionalProperties.
>  - In patch 2/3
>  -- Add Reviewed-by from Geert-san.
> 
> Lad Prabhakar (1):
>   dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1
> 
> Yoshihiro Shimoda (2):
>   dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
>   dt-bindings: pci: rcar-pci-host: document r8a77965 bindings
> 
>  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 115 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 -------------
>  2 files changed, 115 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 
> -- 
> 2.7.4
> 
