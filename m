Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4D2C0270;
	Tue, 27 Jan 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504668; cv=fail; b=tC0z5sR4ewgYyCQ0Zsf+f7GK5DqVrz9WDEj0o42PN7xasPRFM+ejTs0cHhuboU3QEx5o7qOmLCD9S3cGg6fy0UPenUO/47LJCEpzGqTs+aah+vO47Pq63r3pbwEpUT1/iwzDTndFwRtgGWkvaTLTJIA48Z3xiIIf7rcG/ey3zmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504668; c=relaxed/simple;
	bh=cPi6C8EJVRTm8OpNLhve/rItvJGZZOMFhvDtl/xRcMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ru7jysNPIwfr8yYysogd/A9M+sb9wY8hNIIAWN00YwvWXHe7OhokElrzJ99xE59WruK2n9KdREEK07YfNAm9QXNX/Vpv4XhdjXs/AMbuyE5IYhxI4k68o6wJ85/1VehKaCPPrDWml0j/lCBQ18BEUsysYg+TFJnK886cn5cOOCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IfP6cbeM; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfP6cbeM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df6oRl8fdb48UND2JQzRtZNUYkJE8JpQeKlsBdSn1SD25vF+fNPbYZTryqFfmQqhopCIUOidbXsutSb4ciJaGeEE1o3FQFizKsQ8Z38CxQB76JsECV6b0bQX2KVOKieMD6Up/MlQR9cqTilyacUUM03qBS3ITzagNrMv2ZOIL/uPCdECIFt0zLyp4ROILfbJcPSVSE7zQU1x/RlVajNez2OlXoGDvqgzT4uyWiw6yRs+U3KjHWMxODiYuUUwkw8bcvYhBEb4Yl8yOp7ozg+U9Gcf3GnuuA9Uz/ca3xb9iXz9dwY4LJhp1qS/lVqbUHsL/M33hW4I1WKmZ8urEY/pHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1ZFKYIAEHi0kmhe4XiEDHdz2Hx5hbwe2pcJPfXvZbU=;
 b=PefLf9HQPC1vc9k/2F3ecgpdEiWR+qaZgblYcLwlyWhiL7kTUggH02oDXvmNHb8FzSn4owToTSQCd4jIhf5IPRj/3ejiHABJzNMK+XdY1CxDJmCKi7Top7+r99HgsD2Z9u6k/6G2WKO7w805EVtX3SxVXJ+sjseIpLJXlMygdgONNdks1qyQe1ZEoPAOhm5dvYU33X0aVHQBpCYyZwCPpwdlOauqh2cu+J5aCwXYUVzuxvguh7cv9+zYJq7xN07CMIcSplDoV6eCzJMsnZJLo7JyGfOAyeVJ6FjKe4aMz2VOM59sY695X2OI4arpHUjeqc5AzPcF2AB9wOwqTMwSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1ZFKYIAEHi0kmhe4XiEDHdz2Hx5hbwe2pcJPfXvZbU=;
 b=IfP6cbeMhBwjPcLu6eKSzTJcc48R8HUY30YgJxUds/EuhVZsTRaNOgQoC5Xq0Oy01wN4fY6/lUU8aAURIrizmxgtWmabIHtihZJ+RAB5AWsG/oW83RYrcEH+YBeGzxzOjKTUPlK9lxyljPUDuXtfR4uptZMht0LxJ6rcxe9g+Yk=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 09:04:24 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%5]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 09:04:24 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "lkp@intel.com" <lkp@intel.com>, "error27@gmail.com" <error27@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Thread-Topic: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Thread-Index: AQHcdDuaO0M7OyzYOkSdAmoKYSb4+bVl7JyQ
Date: Tue, 27 Jan 2026 09:04:24 +0000
Message-ID:
 <IA4PR12MB9810C452A53425A528D83E37CD90A@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20251223184003.32950-1-rakuram.e96@gmail.com>
In-Reply-To: <20251223184003.32950-1-rakuram.e96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T08:54:25.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|DM6PR12MB4466:EE_
x-ms-office365-filtering-correlation-id: 9ece4dd2-7aef-45cb-13ec-08de5d83116c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OboV+osRxh/RoGvL/LGHnOOfbC0FEzlcnWUDXFzu6SITxG1mSBMoNH8z99Yz?=
 =?us-ascii?Q?cPHyX4RDWTHGeQvxUNZ/+S/QHeRfxk6QM192UesLUtngPHdGJHUa9Wo8it5k?=
 =?us-ascii?Q?DjR0FR/ZtvfetNazM0zTiyTrfO/bWtBcAEvNA8YmLd//Td4DEnrzS0snaJtK?=
 =?us-ascii?Q?xtG7oVtaoVVUNTlN56qZqJkBc5Z+q7TQnPjDooPP5AyQqwAJy5iYXoekA4o0?=
 =?us-ascii?Q?gKw1c1ihf/rbKlFKrhbuOHdOVEJpBgehx4sOrZgMDYOyY9Y5iDoQvU1K168q?=
 =?us-ascii?Q?zp6RUvdOYeQU3T17l3Axw5rpIqmNtzEPS0fD0wPjCPpCRynyprTFpUPkDG1A?=
 =?us-ascii?Q?hbkF9BoWDnHHjyTYIe6tmLTcn1vz720np+9J7freqqULUtu5dwR0HdHtTKm8?=
 =?us-ascii?Q?DjpIHXeRYwxWUzlQbs4zHOFyNNbWZ4n/AyiYd4k6BOo3lko0Eaq/YSuUv7Da?=
 =?us-ascii?Q?6xDsKDHJwZmkNjqbfMSqAlWqoU4vAgtH7N4cBmTc2C2DZMhnyVsojovFYTsp?=
 =?us-ascii?Q?aYgXWSinYIA8ZaKJEHsIVKWTQ+pG3eZdTgIA99rE1R81+Z518ZkwC6dcPqkX?=
 =?us-ascii?Q?6d2s1mpLbtjIBg8Aoo8BRpwuDA/jxHPAeBFjM7a1Cg2bbGHdyyHrrqSgj8he?=
 =?us-ascii?Q?kNmlCb0K6Wu0UxOGgQ/xDgEB/B+YAOBJT3Upq19N7tNJv7PdIg+vqh9zxeWv?=
 =?us-ascii?Q?/6jdU6FvbW8jQh8c/DtkeymAbn2fXrZn0WdMsNyWRshbWg7znl4d9BefYhC2?=
 =?us-ascii?Q?PXJrFeUpY9zatLVN35TJ/AntS0tPBLejTKXQaEBoiWUyeZ/S7GxEmPDr4pnL?=
 =?us-ascii?Q?dADZWJC/b0ezlx2zzJ06Fx1w9/a2Uq2tGCA4colp7KT45DIvhdbJy+dAkE6q?=
 =?us-ascii?Q?LNx1Eq9Vf2HKHOWXB2ZuryYrA3hUOeo4DTmsCLJ4RTQOmliR+di0INBnp5kh?=
 =?us-ascii?Q?mXgEKCAlQTqdIW94HLCxlJ8Gb89MtPCPJK/4HSdKLof8AP1ygGPUHSX78745?=
 =?us-ascii?Q?M7DkXVQY+2q61RZLOnMi4jtpF1xCsl7y7r/+fibqm26+ajlhtATIgABVacrs?=
 =?us-ascii?Q?gbFtjqhftTunfOl7Vbzg1lkztXX5xBfxOcVQ4yKmO5cMdvnZlzxYMrKAM7m+?=
 =?us-ascii?Q?X16Ie0TPuve8WUsHfAbXCybSlSoiu5FwPmO//Ld4rS08KO14Y2eIMvutnN5W?=
 =?us-ascii?Q?wPsWC58CYR7fSsDPU8yZrv+h5ZdFk/xhWeNXBU3jRiGhSl5eMQ3ilzFLGy8w?=
 =?us-ascii?Q?Qh5PPbqKnHt8yQYnaYCLRz7PQlfy/A4+hfdfpq5Qf3JlLHF0VAWWnFeR6WpB?=
 =?us-ascii?Q?HOBqxGToWEEYeycWVtkUpKsZ3jCCJcuuwAjosxH68OTBNRZdpawu/rcg/EgW?=
 =?us-ascii?Q?548fAm+PZrk3zzAQdtLcWaL96dAI8uBfeAOgknUEItpZaq1yaiNhZz0tBoE3?=
 =?us-ascii?Q?FZ0fg8NrxQODgkOXamjbtg0y6NOYrzjmnUBUmoMqakzwDb++pZsTumEWITSa?=
 =?us-ascii?Q?KtUzLHCx5TRM2jjLuRvsVv4pqFvtVhsS4aHzxU6zeFdp3+vucrsa5PEqNTKF?=
 =?us-ascii?Q?d+IfAZeAWh5gycW5pShx75kybN3c3Mc8Ct2TXqCbA91Ui53BnEpXUINn5AgC?=
 =?us-ascii?Q?YkPrbGbkw4uNvYvLrjJUM/w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ieedzndHXtYqqa4Z0KLvQBTOFb9X1UQv57ElsjNmIeL5/P3LlawrYokqzwMs?=
 =?us-ascii?Q?hSD8hVVsuYM9KT4BeVK3nb+LOLM+nBKVI/tICOcsMsoMdWU/i605E23lHS2o?=
 =?us-ascii?Q?bXh/1TJn8mdLZlfARgn2xlR2wtxLvAg/qsNxU4FAxtrH3bmWyRVaA6YykfPp?=
 =?us-ascii?Q?08kgkJM7JMbPhJPVkWH26AnLy1aAj48gi/zKVpR72RdaMXtRDK9I/ePphvhX?=
 =?us-ascii?Q?G1MM7D+7YR9DXoVBY5nnEMwLhEHG9cg3FpaGiqX/Qo2xxRkkP5ScGQ2J4blj?=
 =?us-ascii?Q?fy5/tNljdZswUQmgcYgKEVt0SeKsZfAHpQfHeVSI0STp0IFe3JdgXVA9eoBf?=
 =?us-ascii?Q?Ri15MMgFOTRmC+9XI05n98Oc/AuTD4qLhFWQ6kj4Oct98z5/Ktl+pP7rfTJF?=
 =?us-ascii?Q?tMddrgCnC+5hJdryEQdsux52DUppD3EsA6o3m/mZ4ZWJfR1esFRZndKImURo?=
 =?us-ascii?Q?2dfiva4DGkOb9N/n662OOAJl0fBiF42kXOs6HSV5p+ogwo57vVeRRyIV6RoV?=
 =?us-ascii?Q?Hd/jhLLDf1t7m8nrL1Dlde1hYIyIqxO0G2KrIRKZdOr0utn3n4YcLzGPrFXe?=
 =?us-ascii?Q?mhQTavCd6jHryLJMTYCeWqhBZFGhbdlT0cr9+NUlxiMCwoHw/kx3zS44e6Nf?=
 =?us-ascii?Q?5XxN6EQ3/0Ag1YEJEeuraq2HMIbCnIQD1hKre0tkMXgPhY8gr9x17iIuFA3y?=
 =?us-ascii?Q?SKZoUsOma2R1YurkxPBrGOquqTB+B4mYc3zBS6puvAnnGHMVnwnVtDLlTwz+?=
 =?us-ascii?Q?YR1RSQOTfEtQ92gHDJ/DgBWcem+KJIvhuYfgFIb/5OA/CMjnNeqY6HgwcAm1?=
 =?us-ascii?Q?y4u5qGu30oCKGDe+4L/uiQx5cyAkIMyl955Q1kqDjtT3jJNL/JoWhw2QxoQn?=
 =?us-ascii?Q?8VgJJyV99swkVHgHvcOdRfGnwS0Ay30o2LwvaPvIT0TrGpNxg/9uR+LoftVg?=
 =?us-ascii?Q?xjpqvIyvgHiceOmQ5AlXce97wTeuJX9pgoF84MVAQaDhCfArbBN8fYZ11RJ1?=
 =?us-ascii?Q?4jMFeh+iVLPY0Wh4nLJ7Br4z/1OwD/QFHw/OgZxsTLw0mzHcQB5uJ9Wg4vzJ?=
 =?us-ascii?Q?zMsc1UptUuHH7VzbvkeJU7KW8K9hpbGO5FxRar2xjMfm+fyAbkbBcI02RAEy?=
 =?us-ascii?Q?nii/YdJihmWjTiWgCGtzhHHPX8BUs+4ScQIoz4sctMLWgfGwtOqks2IA4LB7?=
 =?us-ascii?Q?3WERPhHjiACIsKfGzWBaZRJvSEXdui2hMY2uekfX8eBpXuQphyOr27Ytghc9?=
 =?us-ascii?Q?52QYyaVtDE0j155ENUpeUaFauUijz302+78t+j0PK5CAswaNOasVyiFvDjms?=
 =?us-ascii?Q?WZ4UR5ZJAKMFRkGMvoP4kXW9YjVEsas44g3VcBZwjIRXvgW62/SLAat6Hheu?=
 =?us-ascii?Q?O0t6r5v5O7N5yjS6D0KJaZ5mk6FIDfoj3+8GDNc7EIv8xo1JZSdn8dYz1rmW?=
 =?us-ascii?Q?UoPgKHa53OVc587+bagKuqkQ2FIddE0HqU5+oGvOk+UnQjO/Xaez7XK196vR?=
 =?us-ascii?Q?KbQQfW77hG/uI6Kv8R+DyRR+1EBfFueNffrBVzyEQtroeBqtDyXoN5Rivk/y?=
 =?us-ascii?Q?Fuhy/NZ4Uw/rUK+h1qap1ABx0Ks2PHvTNKs4+AUPOZ0nklLbDeedud+ZNEP9?=
 =?us-ascii?Q?iNjRspTE2wfX+H9TOT3qidrkdUL61Y2HIk3C7VdRG+prY4HAXUfHWTZ1/o7B?=
 =?us-ascii?Q?09YquDipy1OqKK63g8OrX55/jp1Y8XSEkhe6xa3E0eUe+WIp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ece4dd2-7aef-45cb-13ec-08de5d83116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 09:04:24.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAwy0BtYGbPYyOUCBhgTSKUtMNR6rzciAdCYShtD51lPmU7LRrZyEtX5vI0161zqBiEUSFXQXU0MbXD355FUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Rakuram Eswaran <rakuram.e96@gmail.com>
> Sent: Wednesday, December 24, 2025 12:10 AM
> To: lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com
> Cc: lkp@intel.com; error27@gmail.com; Musham, Sai Krishna
> <sai.krishna.musham@amd.com>; tglx@linutronix.de; jirislaby@kernel.org;
> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Rakuram Eswaran
> <rakuram.e96@gmail.com>; Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error mes=
sage
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The INTx devm_request_irq() failure path logs an incorrect IRQ
> number. The printed 'irq' variable refers to a previous MDB
> interrupt mapping and does not correspond to the INTx IRQ being
> requested.
>
> Fix the error message to report pcie->intx_irq, which is the IRQ
> associated with the failing request.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202512230112.AaiGqMWM-lkp@intel.com/
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> Testing note:
> Compile-tested only.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command using for testing:
> ~/project/smatch/smatch_scripts/kchecker ./drivers/pci/controller/dwc/pci=
e-amd-
> mdb.c
>
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
