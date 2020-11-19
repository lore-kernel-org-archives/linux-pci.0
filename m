Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758CC388F9
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EDB22226
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 19:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MEvmfNVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKSTEx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:04:53 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:59308 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgKSTEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 14:04:51 -0500
Date:   Thu, 19 Nov 2020 19:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1605812687; bh=mGRxcfYAolC/NAFMZCqEsZ2XXtf/Sf6e5ygXw0wgKUk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=MEvmfNVu1l/+M20A+8ShDsCBsLr3t1Is6Icz36mhsLHKeha+urkYFvIxxi4H4kuTm
         LOJs7Bn5M8NQ+EGt1LHHPoj1HxZJ/NcFvQY2DK2aDYLx028jtyy9PYjymdLx9dr89q
         Us/fH6fD4mNdUTbq6HdRrYGlM2OZxtmZiRlgijTKkLpDcwl06Wp0jQqQIxJ5q1ezES
         yk0AioPpW7PtAVr6cn8FQiNH7z0eyDjhO8j5ZiOE4Hp3xu5xhkA9Yf5wu7v+u7/T9F
         Lm44VJfG6ZFGxLx6l8Gv18rhNNOLLNMUP89GCYhRKURqMk+C0eUCCX7+A0YC/hPm/1
         GBAnwv1cAcHRw==
To:     Bjorn Helgaas <bhelgaas@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH pci-next] pci: remap: keep both device name and resource name for config space
Message-ID: <JvyOzv8K8n5CCdP1xfLOdOWh4AbFrXdMMOEExr6em8@cp4-web-036.plabs.ch>
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
19000000-19ffffff : pci@18b00000
  19000000-190fffff : PCI Bus 0000:01
    19000000-1900ffff : 0000:01:00.0
  19100000-191fffff : PCI Bus 0000:01
1a000000-1affffff : pci@18b20000
  1a000000-1a0fffff : PCI Bus 0001:01
    1a000000-1a00ffff : 0001:01:00.0
  1a100000-1a1fffff : PCI Bus 0001:01

After:

18b00000-18b01fff : 18b00000.pci dbi
18b10000-18b11fff : 18b00000.pci config
18b20000-18b21fff : 18b20000.pci dbi
18b30000-18b31fff : 18b20000.pci config
19000000-19ffffff : pci@18b00000
  19000000-190fffff : PCI Bus 0000:01
    19000000-1900ffff : 0000:01:00.0
  19100000-191fffff : PCI Bus 0000:01
1a000000-1affffff : pci@18b20000
  1a000000-1a0fffff : PCI Bus 0001:01
    1a000000-1a00ffff : 0001:01:00.0
  1a100000-1a1fffff : PCI Bus 0001:01

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


