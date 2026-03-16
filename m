Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4529BD87;
	Mon, 16 Mar 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669781; cv=fail; b=OfKpZEQ6WehWzBLAsr9vW0CVwglJiP8l7Cg4IyPP3/4ERjQwPKh02LHdmHIdePunDZmpSEip3MJzbqLwKzY7qxV2L2AGVt0BYCA4DHLRYLU0OTKHG4vozclN0atUPeIBum5jjlCZtikwDDlJrpHEO3KsNdrhN/oF/WAla7SOFMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669781; c=relaxed/simple;
	bh=xGgayB+9XnUz8NSw0rPIl8Z7SlBmuiWxmdKiVzo3Huo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a32aVAqbs9JqkatWEpkm9f86NNJrjiw+4QosVh5KHOdfGSna0b5jw6K5JIVI2rjke/si6WXVCcPWWbfSxshfcr7qD4llRZdOQNQqLIgE+94dyK+fkZ68akkSsmJTkMmJ6mKCYFx3l+C0FBTF8o+QaszTAnomSZ1T5a/QAKu4l70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tqg1qMeS; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqg1qMeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRajpIy/tMpuZl5iuMJRsrG/SOvIqvJQqHug6SE+jtIxvOzottNg/rLN4yR/qYljPFw7hEU6fYswI1Aray1TUYYiW2yyPjni1MWHtXG0xSFhhZaNCL75yxYxL4M4O9fBHtf9dglRVNFfT1bBgFWYjQymXEDqgFFSovfvWlbfxOlaiUw9Fjs2sW9P62V5t1jn2bQZcbggMyVh4C+sNEBkjgGoF5xbLACceVGjebZN72KApihUauO1+oMDqE6WRe72Q+OYsxLvO2/AZuMx6gWfgnlOKgAjGk5Ai+lCr5e3HSKYvgcnOs93565DY1s7NHeJCyILybgS0tlmUqU9th5ncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiwNDvjA4638xEDL94fH8FywLGWfcFpjPDdLbO2k51o=;
 b=NRV0RP9ELY5vWH2PJnvCMByQupbGrkb2QmcpV2Ut3PQXIisTVNBnUHlLuDzSKYn/xWWrn/fZyEjUO7HhzAzxZmVTEBh5JjS9IF994YiZXWOPBdqFsfFMi8zgVKZmngwcbQV4zcq4DahPfRw/tBRMplpvZJYyO/KMBDfvoU4IZjQpj/eQ1qGcdrMimTK9UdtEqJ8UsJl+gY7+roOtLrCNnoOo5criYXNGp/MWbHfTQ039BLSqlSXdJX43V1ozpJxUwPPLl2c4zNErdy6kRDlzMurDtxKyh37Vqr9EatJG6/mGBmSWmiDNacIFafXmsccSUZqtOaANFjmgX1J1M5kZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiwNDvjA4638xEDL94fH8FywLGWfcFpjPDdLbO2k51o=;
 b=tqg1qMeSjqk7B5scY1VbPXMM3tWzUATKQR5/8HkoeWtfxBy94ssusoEvgV7yKXa6oZcbySiJsU1EYXkSYDy1QTspzpl5giDEoUlvf1cAbqajDERiZgKhk/2m/lynEKgLoZcXXOTpCOxIAqGqsElesBg5RmxJf+eGkN7U+pqdVsQqN1dshyW5xFG+aZFtYw6DB1xRsoIX8lr5LmKHK0KuMOcrBjg//12AiNNv3bGZDpVza6qLuQ68b75eLNP+3jC5uUix7QF/UfN9J7aLh5Jdh70Sl1ZRJRSAG6haqpGlvqyf3tf/uqvfEeS8AoauEKvgtZn7aJ8o1WX9zzHLJP2wLw==
Received: from SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 16 Mar
 2026 14:02:56 +0000
Received: from SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b]) by SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 14:02:56 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, Srirangan Madhavan
	<smadhavan@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>
CC: Alex Williamson <alwilliamson@nvidia.com>, Jeshua Smith
	<jeshuas@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy
 Kancherla <skancherla@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Vidya Sagar
	<vidyas@nvidia.com>, Jiandi An <jan@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Derek Schumacher <dschumacher@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register
 definitions
Thread-Topic: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register
 definitions
Thread-Index: AQHcrT9cOEaAtayjPEyQ2kWebLl0mrWoU4WAgAjseFc=
Date: Mon, 16 Mar 2026 14:02:56 +0000
Message-ID:
 <SA3PR12MB9131BF1477CA8B87E8FD70EBBB40A@SA3PR12MB9131.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <20260306080026.116789-2-smadhavan@nvidia.com>
 <69b090a110f0e_490a100b8@dwillia2-mobl4.notmuch>
In-Reply-To: <69b090a110f0e_490a100b8@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB9131:EE_|CYYPR12MB8938:EE_
x-ms-office365-filtering-correlation-id: bc26886b-42cf-4185-7da6-08de8364b953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 VJVZKEWjqvMnmuIOGI/G9tui5tnRgn5ohkTlcUpNh3r7lxWYiHUooj0lx606b/97KxVAU0QGQmtLpLcIo+MCraXUnBgzcABuGfdxwERt6xAskYF6gkbtPlvhT7xZDipSgx/+CAhCrs9DfXmQYMgNNwLXnG/ay9iKh/62jn41VHoK3n9oqj2z4LGXp6vP5VLB/S7UlLWxG3Cx2tg2A96A7sGbeYIjsiKkmvymwrbbJ+d5u1UspOhyU9STQDm9+xkLKyEiFl7/SeGdnIibZaPlkkR2Pw36GYph1PXvvNRX9T1BziZx/X6g19uT7p1i95aCS7VTliuHuLZx4ZDQFOPTYtUQJVbsoRgaID8oTGLD59d4poYHyyWE4paWmptWezwfvMJVI4vJi12bRnNpkXKopshyjlLfQQUxypEQI7kJ2e+J3hND8qAh6DDy+XtClS9ok9Mevq0ZFjHtgI7UsgU7AYLBjbJse9R+V94h8SnZeE4vfAbFoK6mnZS6wdxaV/UduL1SXT3v2LeiMY2SEuDS2O+eoH8iSrupBekvdCkmtyk/dE4JmpkAIbsoOqLaVP2Gu4WlKAv/Pmbbq/uXEP4u0eQF3zFxV0vVwBtuf1eC0f0g/bLhT3ydBWuh7HjX/nktUjwyauz3AJttIc/dx5cT1n/MNYVlmEZ4NrslHuG3val5YxAagvFiDfwZqCgK9d/PoO6KsGWooBhyVz/5xrlVyo90sqVBSw6B7HlGMnClNH7GNQjvKDJFqpoEaIt/hvtN1Vbzr28zV5kW3E+7u5F5a7ugx0mWVWL4cPP9c73IiYI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bnhJN1DVQFV2LXth7R0WlTgtqJ2VdHi7WSE05JTdrTs6IFcZ6fQtCq5Q2Q?=
 =?iso-8859-1?Q?devbbwby2PenMUfujXsz0B/rPW0aO9dKiXuCSsdzTAYmdfI6W066J/OhA3?=
 =?iso-8859-1?Q?dONg1m3/sFw06grOCXa+RkUFpKSIjc2zNgTuD9/3R/DOYgyhXAomlDZmP/?=
 =?iso-8859-1?Q?2AjsngfXEku7jLy0ovJ9vx50URTBUtpiSpkHoX+2qRnogjd4mfXkXiMjnZ?=
 =?iso-8859-1?Q?VbXznvBno8tDbfBFkvoCQLihx6rqsqCEyaOxC//R7lLoZqLwTEwplqxK7G?=
 =?iso-8859-1?Q?kYXxlSKkC/L/krFcfIE0nlZ7o1G89AGj3Pznm3pzbjU4FbZ+COZACVr4Ru?=
 =?iso-8859-1?Q?MnqSEoawa8oxe6UYIhf4Uw2nyZraEXHvA1+TDEePH5j0HIC1Cy//qM9fRl?=
 =?iso-8859-1?Q?gqJRxONxj6frdiUTIXOcQDB7Aomae6vnnWIp4PtPwli95oXzEcnhWJt/3j?=
 =?iso-8859-1?Q?VvksjgPfAykBX7S69CYS6cXwaIwIcshoECZew1z3Ca2fVx+9YIG+3fw5yI?=
 =?iso-8859-1?Q?Lu4ijiTtKzVnAsXKH0jYS6ODegEfs/YeKywQx1MwFzo7xoubAHPu7pTPhl?=
 =?iso-8859-1?Q?FAvqjAylAsbYqhqRMg9aKqZztppHEVtRE79xyrt9M8XSDdlQjJFU7X60wb?=
 =?iso-8859-1?Q?smBVxkZvzh9KFWWTGnck08QdKd4Jpn1tUS8zP8Ell5JZgAlwqPWfvm29cB?=
 =?iso-8859-1?Q?ETY1CnjJkx6dvuHfvhJXXS2Zyd2422DjoDc6jVW9tbzJPekMcgLUcO8k4j?=
 =?iso-8859-1?Q?+XWptmQMBzQvB8Jrl4Hoclb8JByB8ZMlyqrJYE6+SHSkCRlhof6o4h7jQb?=
 =?iso-8859-1?Q?rNWBDp9EornsHIJSHVTfKfpbnw2UtPuBnz9iZ/FTA2tK0dFGeJ7KUMjipa?=
 =?iso-8859-1?Q?cLBa6CnUryzKM4+cHQSE9d+SA+h/iZ4OI4T4aHbbkuqqbnaQ8UEGjf+n/2?=
 =?iso-8859-1?Q?/3aCiHaLlYACf+lgCjhkTEs25/H1jmzmp3HHMcTDUTGRP/bxhjiwRU2CA2?=
 =?iso-8859-1?Q?l/o9h6vQnVGK+32yDq5MSWyd3mw3MEQqgvjbL4t9k8JxbiW3fvv7jJ/6QP?=
 =?iso-8859-1?Q?g6U2UP5wUN3cpBe8y99U4prsRfGfOXE47D6Zfh5nnGO+P5Yqbxwbxo9gH/?=
 =?iso-8859-1?Q?OURJv8zV7CTGpKAlzH523h3Fow07UfHQfIc8d0EBZYhK8FI6PiI6ELWUT/?=
 =?iso-8859-1?Q?w8nUn4FHsroIuXR6fSXtNT+ixx2E2EZQKkLEXtCBHg9vFswBSXK3IuGyF2?=
 =?iso-8859-1?Q?+QOJe9bcRAQHEGyA840iEm8iFERjM/RGxW4ZeN59sjnyIW4D11ayVgfwVf?=
 =?iso-8859-1?Q?GQb8Fb3wRH2bwNwGWz/t5CoL9D7TpiILTZNZ/JeHrZcLm2bSvOBTgK6L9m?=
 =?iso-8859-1?Q?GwaCmJoySEn7TCnjjg1/+hODLOyAfeCvE0e9FN7yj9iofuc9g7KVc/EL0j?=
 =?iso-8859-1?Q?NMzqtBlzJxLBRSHZPCLa/rSvrRY0kd8/CYCvacHy3KxmQd2EMYpBD8KGF4?=
 =?iso-8859-1?Q?R2lJg/HXRfzbnyWoCy1xboOVNC3LEc9aFDfCewM/lET7VwXM8RXWiCxgBp?=
 =?iso-8859-1?Q?fGq6SYsrvOwX2HSHYgPBHBWTbUhghWfL+5KSfKwZQ75UOt3B7drbb+KcXD?=
 =?iso-8859-1?Q?KCcSbZbr38ExD1ndCaWyXu3lCv9P8ZKAozj9XE1cBiWoAQ+8mUQhFbeOtL?=
 =?iso-8859-1?Q?E5AD/SKcVvhA+9gNTruRvVuzcOqfLccFsP78IwLjHTc+Fd+6jM+Dk+YDGl?=
 =?iso-8859-1?Q?riRxSh2wJe1e/X9ky1rOp0Vp+ZWkgd4jz9jDXwnm6oYCmA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc26886b-42cf-4185-7da6-08de8364b953
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 14:02:56.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0qgCFRO+8DFbgPXaBWHqN3No09w9Puc6+YYDCjWvqlQORx+Te7rovM8oD0NPWAQ1oZotqPR8pryZd+cpVCjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938

I am wondering..thinking out loud here..what if the cxl "driver" (e.g the p=
ort driver) registered for its own "reset_prep" and "reset_done"? Or would =
having the cxl specific routine in cxl driver that pcie reset path calls in=
to work? I realize the 2nd suggestion may not address the main concern but =
it's an improvement.=0A=
=0A=
-Vishal=0A=
________________________________________=0A=
From: Dan Williams <dan.j.williams@intel.com>=0A=
Sent: Tuesday, March 10, 2026 4:44 PM=0A=
To: Srirangan Madhavan; bhelgaas@google.com; dan.j.williams@intel.com; dave=
.jiang@intel.com; jonathan.cameron@huawei.com; ira.weiny@intel.com; vishal.=
l.verma@intel.com; alison.schofield@intel.com; dave@stgolabs.net=0A=
Cc: Alex Williamson; Jeshua Smith; Vikram Sethi; Sai Yashwanth Reddy Kanche=
rla; Vishal Aslot; Shanker Donthineni; Manish Honap; Vidya Sagar; Jiandi An=
; Matt Ochs; Derek Schumacher; linux-cxl@vger.kernel.org; linux-pci@vger.ke=
rnel.org; linux-kernel@vger.kernel.org; Srirangan Madhavan=0A=
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range regist=
er definitions=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
smadhavan@ wrote:=0A=
> From: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
>=0A=
> PCI: Add CXL DVSEC control, lock, and range register definitions=0A=
>=0A=
> Add register offset and field definitions for CXL DVSEC registers needed=
=0A=
> by CXL state save/restore across resets:=0A=
>=0A=
>   - CTRL2 (offset 0x10) and LOCK (offset 0x14) registers=0A=
>   - CONFIG_LOCK bit in the LOCK register=0A=
>   - RWL (read-write-when-locked) field masks for CTRL and range base=0A=
>     registers.=0A=
>=0A=
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
> ---=0A=
>  include/uapi/linux/pci_regs.h | 6 ++++++=0A=
>  1 file changed, 6 insertions(+)=0A=
>=0A=
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h=0A=
> index ec1c54b5a310..6fdc20d7f5e6 100644=0A=
> --- a/include/uapi/linux/pci_regs.h=0A=
> +++ b/include/uapi/linux/pci_regs.h=0A=
> @@ -1353,14 +1353,20 @@=0A=
>  #define   PCI_DVSEC_CXL_HDM_COUNT                    __GENMASK(5, 4)=0A=
>  #define  PCI_DVSEC_CXL_CTRL                          0xC=0A=
>  #define   PCI_DVSEC_CXL_MEM_ENABLE                   _BITUL(2)=0A=
> +#define   PCI_DVSEC_CXL_CTRL_RWL                     0x5FED=0A=
=0A=
This is odd, why is it needed? If the bits are locked then writes are=0A=
dropped.=0A=
