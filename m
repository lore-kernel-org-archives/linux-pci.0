Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15523E8C4B;
	Tue, 31 Mar 2026 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968142; cv=none; b=Ncn5ZUkFyvDNDvDPRwYyavdrJsfdqzbIqQtH5NKjSanM7I0g0rM0vglo3aq+rWlLTCPubijcZj4we2S4404Q2tDWw1mzgSdfcQNqyE9fsk/vxgErbSCIT0b9SJ+c5AUK6AOYLE1hk8OdYhBWHbGi9XuNMiv+e4PtuVSjsDVSSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968142; c=relaxed/simple;
	bh=fYIT+cqEDxgHSO28QxCRmWesd/bKgSrSZYDth0wro10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8rr4Ephz0W5GLvp3MCoeUGwQjK6Em/TB+LLH/t7Yzcn5YMAhre0VH7oZB6Pm+sFNqIOy9dLado/84YADo+ueSP/fAe8EWBG1p/5MXz5cV2yTR/V5NV7zw5Hx9wZDVWzV0FyjeDvWp3z+J4SYMHxNWw+WTMNA1j7+ckg5liVV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flW5h6S3GzHnGdq;
	Tue, 31 Mar 2026 22:41:28 +0800 (CST)
Received: from dubpeml500006.china.huawei.com (unknown [7.214.146.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4300540587;
	Tue, 31 Mar 2026 22:42:16 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml500006.china.huawei.com (7.214.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Mar 2026 15:42:15 +0100
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Tue, 31 Mar 2026 15:42:15 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Tony
 Luck" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, "Len
 Brown" <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao
	<leitao@debian.org>, Jason Tian <jason@os.amperecomputing.com>
Subject: RE: [PATCH v3 1/3] ACPI: APEI: GHES: Add
 devm_ghes_register_vendor_record_notifier()
Thread-Topic: [PATCH v3 1/3] ACPI: APEI: GHES: Add
 devm_ghes_register_vendor_record_notifier()
Thread-Index: AQHcwCmNhLqdgm9+6UO86Dnyr2nw5LXIuGrg
Date: Tue, 31 Mar 2026 14:42:15 +0000
Message-ID: <1d4350a5e55640c68d051229e8d79576@huawei.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
 <20260330094203.38022-2-kaihengf@nvidia.com>
In-Reply-To: <20260330094203.38022-2-kaihengf@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
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
><shiju.jose@huawei.com>; Tony Luck <tony.luck@intel.com>; Borislav Petkov
><bp@alien8.de>; Mauro Carvalho Chehab <mchehab@kernel.org>; Shuai Xue
><xueshuai@linux.alibaba.com>; Len Brown <lenb@kernel.org>; Robert Moore
><robert.moore@intel.com>; Fabio M. De Francesco
><fabio.m.de.francesco@linux.intel.com>; Breno Leitao <leitao@debian.org>;
>Jason Tian <jason@os.amperecomputing.com>
>Subject: [PATCH v3 1/3] ACPI: APEI: GHES: Add
>devm_ghes_register_vendor_record_notifier()
>
>Add a device-managed wrapper around
>ghes_register_vendor_record_notifier()
>so drivers can avoid manual cleanup on device removal or probe failure.
>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
>v3:
> - Change patch title
> - Move documentation to header file.
>v2:
> - New patch.
>
> drivers/acpi/apei/ghes.c | 18 ++++++++++++++++++
> include/acpi/ghes.h      | 11 +++++++++++
> 2 files changed, 29 insertions(+)
>
>diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
>8acd2742bb27..3236a3ce79d6 100644
>--- a/drivers/acpi/apei/ghes.c
>+++ b/drivers/acpi/apei/ghes.c
>@@ -689,6 +689,24 @@ void ghes_unregister_vendor_record_notifier(struct
>notifier_block *nb)  }
>EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
>
>+static void ghes_vendor_record_notifier_destroy(void *nb) {
>+	ghes_unregister_vendor_record_notifier(nb);
>+}
>+
>+int devm_ghes_register_vendor_record_notifier(struct device *dev,
>+					      struct notifier_block *nb)
>+{
>+	int ret;
>+
>+	ret =3D ghes_register_vendor_record_notifier(nb);
>+	if (ret)
>+		return ret;
>+
>+	return devm_add_action_or_reset(dev,
>+ghes_vendor_record_notifier_destroy, nb); }
>+EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
>+
> static void ghes_vendor_record_work_func(struct work_struct *work)  {
> 	struct ghes_vendor_record_entry *entry; diff --git
>a/include/acpi/ghes.h b/include/acpi/ghes.h index
>7bea522c0657..8d7e5caef3f1 100644
>--- a/include/acpi/ghes.h
>+++ b/include/acpi/ghes.h
>@@ -71,6 +71,17 @@ int ghes_register_vendor_record_notifier(struct
>notifier_block *nb);
>  */
> void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>
>+/**
>+ * devm_ghes_register_vendor_record_notifier - device-managed vendor
>+ * record notifier registration.
>+ * @dev: device that owns the notifier lifetime
>+ * @nb: pointer to the notifier_block structure of the vendor record
>+handler
>+ *
>+ * Return: 0 on success, negative errno on failure.
>+ */
>+int devm_ghes_register_vendor_record_notifier(struct device *dev,
>+					      struct notifier_block *nb);
>+
> struct list_head *ghes_get_devices(void);
>
> void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
>--
>2.50.1 (Apple Git-155)
>

