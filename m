Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01734C388F9
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23F522259
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 21:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cQLaXduU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKSV0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:26:46 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:32088 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgKSV0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 16:26:46 -0500
X-Greylist: delayed 8517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 16:26:45 EST
Date:   Thu, 19 Nov 2020 21:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1605821204; bh=pKqQfrVJcKcU3ZYHnLUfBraKNSIcU7V0RaxaYm3S38c=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=cQLaXduUcxc5c/ZUKlv35V73fuNkB0kr5swYWPhTSth+/SWrNWNyGfoygppdi1udM
         FyYkBD79zy8wt8TDRJPnXS7T+5MyWWWHCaoj1pM5U5Q5KrSIsI827nFg7gybaepcyV
         kbwkzaeOmfqfa8TG6sAqhRxzKtpW0N6SCH7iRCIvtDDa/saArD3fodGtdLHyIt9P33
         fF8+x3Zd1AxZDtBWxvau2usaqqOxHsjZPtyirQlVLWoSM4AUtVn+mj/Y/WUJwQhKxX
         09X+AKx7xZKU+5UTEKFxQ4b3cbOfctiRmXwyaFt7+Yb8F3gk4H4Uz/1gPOjyeTCOmJ
         j/rhWl/i1pwNQ==
To:     Bjorn Helgaas <bhelgaas@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v2 pci-next] PCI: Keep both device name and resource name for config space remaps
Message-ID: <WbKfdybjZ6xNIUjcC5oC8NcuLqrJfkxQAlnO80ag@cp3-web-020.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow the rule taken in commit 35bd8c07db2c
("devres: keep both device name and resource name in pretty name")
and keep both device and resource names while requesting memory
regions for PCI config space to prettify e.g. /proc/iomem output:

Before (DWC Host Controller):

18b00000-18b01fff : dbi
18b10000-18b11fff : config
18b20000-18b21fff : dbi
18b30000-18b31fff : config

After:

18b00000-18b01fff : 18b00000.pci dbi
18b10000-18b11fff : 18b00000.pci config
18b20000-18b21fff : 18b20000.pci dbi
18b30000-18b31fff : 18b20000.pci config

Since v1 [0]:
 - massage subject and commit message (Bjorn);
 - no functional changes.

[0] https://lore.kernel.org/lkml/JvyOzv8K8n5CCdP1xfLOdOWh4AbFrXdMMOEExr6em8=
@cp4-web-036.plabs.ch

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..0716691f7d14 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4188,7 +4188,14 @@ void __iomem *devm_pci_remap_cfg_resource(struct dev=
ice *dev,
 =09}
=20
 =09size =3D resource_size(res);
-=09name =3D res->name ?: dev_name(dev);
+
+=09if (res->name)
+=09=09name =3D devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
+=09=09=09=09      res->name);
+=09else
+=09=09name =3D devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
+=09if (!name)
+=09=09return IOMEM_ERR_PTR(-ENOMEM);
=20
 =09if (!devm_request_mem_region(dev, res->start, size, name)) {
 =09=09dev_err(dev, "can't request region for resource %pR\n", res);
--=20
2.29.2


