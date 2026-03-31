Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753393FEB3A;
	Tue, 31 Mar 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968187; cv=none; b=cqDJpKducSJs2JebiJ1u1JdVrLpU2xn6Bxsv7fM9NxnZp3w323yLGrLF1E2pbgRnatlbTB01lijdQnr6c29knovI5WB2KovY2JKqGM+FyjFYnCmRzgoSEuaEn5OJ3G+VFFXt7kr199+V5vw8FgtGq1sHhqvIYcCHLjKgEbBrCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968187; c=relaxed/simple;
	bh=RcutVLH4ifDqVEewW/8atXJEPACAAbD1siu51Zk+UpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVgjNEfUnDqYMfImk25XagOBDViwX8Sb9EfJgNUTkCd/Y6jVHjPzxtWr2CICep0DxdW71a+OHTjQAQpujmBGoZWMKDqAXYUIyalx+Wg2ECQIgjkBoU4kMgRO2Oj+FSC09sPZ1ccE4p+uZ5MJfRQa15BOPJ4ISiy3OSZE9b5gPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flW782CJszJ46Zg;
	Tue, 31 Mar 2026 22:42:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DE46340575;
	Tue, 31 Mar 2026 22:43:02 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Mar 2026 15:43:02 +0100
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Tue, 31 Mar 2026 15:43:02 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v3 2/3] PCI: hisi: Use
 devm_ghes_register_vendor_record_notifier()
Thread-Topic: [PATCH v3 2/3] PCI: hisi: Use
 devm_ghes_register_vendor_record_notifier()
Thread-Index: AQHcwCmOsWn+rfU5UkCm5UXnGSPoCLXIuNFA
Date: Tue, 31 Mar 2026 14:43:02 +0000
Message-ID: <05dbb75491dd4b75b5080c985a29e9e7@huawei.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
 <20260330094203.38022-3-kaihengf@nvidia.com>
In-Reply-To: <20260330094203.38022-3-kaihengf@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Kai-Heng Feng <kaihengf@nvidia.com>
>Sent: 30 March 2026 10:42
>To: rafael@kernel.org
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>;
>helgaas@kernel.org; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>pci@vger.kernel.org; acpica-devel@lists.linux.dev; linux-
>hardening@vger.kernel.org; Kai-Heng Feng <kaihengf@nvidia.com>; Shiju Jose
><shiju.jose@huawei.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysz=
tof
>Wilczy=F1ski <kwilczynski@kernel.org>; Manivannan Sadhasivam
><mani@kernel.org>; Rob Herring <robh@kernel.org>; Bjorn Helgaas
><bhelgaas@google.com>
>Subject: [PATCH v3 2/3] PCI: hisi: Use
>devm_ghes_register_vendor_record_notifier()
>
>Switch to the device-managed variant so the notifier is automatically
>unregistered on device removal, allowing the open-coded remove callback to
>be dropped entirely.
>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
>v3:
> - No change.
>v2:
> - New patch.
>
> drivers/pci/controller/pcie-hisi-error.c | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
>
>diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/contro=
ller/pcie-
>hisi-error.c
>index aaf1ed2b6e59..36be86d827a8 100644
>--- a/drivers/pci/controller/pcie-hisi-error.c
>+++ b/drivers/pci/controller/pcie-hisi-error.c
>@@ -287,25 +287,16 @@ static int hisi_pcie_error_handler_probe(struct
>platform_device *pdev)
>
> 	priv->nb.notifier_call =3D hisi_pcie_notify_error;
> 	priv->dev =3D &pdev->dev;
>-	ret =3D ghes_register_vendor_record_notifier(&priv->nb);
>+	ret =3D devm_ghes_register_vendor_record_notifier(&pdev->dev,
>+&priv->nb);
> 	if (ret) {
> 		dev_err(&pdev->dev,
> 			"Failed to register hisi pcie controller error handler
>with apei\n");
> 		return ret;
> 	}
>
>-	platform_set_drvdata(pdev, priv);
>-
> 	return 0;
> }
>
>-static void hisi_pcie_error_handler_remove(struct platform_device *pdev) =
-{
>-	struct hisi_pcie_error_private *priv =3D platform_get_drvdata(pdev);
>-
>-	ghes_unregister_vendor_record_notifier(&priv->nb);
>-}
>-
> static const struct acpi_device_id hisi_pcie_acpi_match[] =3D {
> 	{ "HISI0361", 0 },
> 	{ }
>@@ -317,7 +308,6 @@ static struct platform_driver
>hisi_pcie_error_handler_driver =3D {
> 		.acpi_match_table =3D hisi_pcie_acpi_match,
> 	},
> 	.probe		=3D hisi_pcie_error_handler_probe,
>-	.remove		=3D hisi_pcie_error_handler_remove,
> };
> module_platform_driver(hisi_pcie_error_handler_driver);
>
>--
>2.50.1 (Apple Git-155)
>

