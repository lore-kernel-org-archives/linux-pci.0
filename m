Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA69C32772
	for <linux-pci@archiver.kernel.org>; Tue, 23 Aug 2022 15:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiHWPOx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Aug 2022 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiHWPOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 11:14:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A014BC46;
        Tue, 23 Aug 2022 03:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E3F8B81CD7;
        Tue, 23 Aug 2022 10:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5967C433C1;
        Tue, 23 Aug 2022 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661250226;
        bh=kC4x/A3kZfzPl/pa7iL9FC5eEKDJ5Ac2k3V1EyxgCC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcqjASlDthKjOLxlKjyeYZK8KAtYoQmPAqTSqbM83upKOp1ytdybG2k8Ot9ZOeAG/
         FAgEbXRWQV5W+OvDTXF/LWtOOJzPiAOQEBiCOYA0vueY0GZMJKpQvnEJri1b0h7Rn/
         GczAUcZqM4Cv75S2CwSWMHKuoawidcaabcsvsTcAw0Bo6I869U97vS5KhKNsdcsrnj
         8m1snHByn1yy0Dk0aG2uP8vosgy3jt1NEY0Zh0e2AQ/EdK5Cicn9u6kaMFw/vNDiTs
         dsM6kjWP7gZjmKFRG0RlDcHun76bvV9I/Uz8KeYw3xlJRlVTo03e7tA4SEIUUfK9t1
         oi37iwKdCcuKg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: mvebu: Fix endianity when accessing pci emul bridge members
Date:   Tue, 23 Aug 2022 12:23:40 +0200
Message-Id: <166125018774.51610.7934595303191264022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220812141115.24082-1-pali@kernel.org>
References: <20220812094058.16141-1-pali@kernel.org> <20220812141115.24082-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 12 Aug 2022 16:11:15 +0200, Pali Rohár wrote:
> PCI emul bridge members iolimitupper, iobaseupper, memlimit and membase are
> of type __le16, so correctly access these members via le16_to_cpu() macros.
> 
> 

Applied to pci/mvebu, thanks!

[1/1] PCI: mvebu: Fix endianity when accessing pci emul bridge members
      https://git.kernel.org/lpieralisi/pci/c/2e379ac66d4b

Thanks,
Lorenzo
