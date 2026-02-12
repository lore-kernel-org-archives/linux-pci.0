Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CA3EBF1B
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889358; cv=fail; b=hymORLay1uvjvyDTgtrFSYVmUs1vQ91OrSTsSe0hHZa2VlJjvfwL0lI8wYjACHxKUw2OgXmL59p2Sj4Zb8YqFlz0UXQ4PJE6mFs88DSX1tGp8CsUCDcq/Mufo9KwV8ew3njVu8fqy/HCIg4jGoIiS1ce58G9twA477PLQ5xuyQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889358; c=relaxed/simple;
	bh=qfpHZVVkHg7UoOtb+WM8LaaZegcPePhAizOfUEdmQow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pvH1A6iq4BEIk8WWdC6BiGCSprtuPPz16rYdmaEBElHd3YnB5wlvB2x1l5TkO0rtGVCFshJD1NijMIT+hoNpICGEB44QI4RBKp4dqznBMDJMsUGCgfK85CjeDhg/GdhHyZpPNQ9wePZO0Dl7jENGd0Vmn2MRDJW9xtsxwv0WugA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h0jAkMMQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C0J+Buv8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h0jAkMMQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C0J+Buv8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770889357; x=1802425357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qfpHZVVkHg7UoOtb+WM8LaaZegcPePhAizOfUEdmQow=;
  b=h0jAkMMQL12BQLUgWamTj7Mh1wM3yLjUeizY+J4f4sGz9LvCBpTmftHE
   jVR0CVyIxAi675DaezY4dfHmdf5fAK8Fun3090z8Z8a+GKWSBZQrv+ocJ
   ZzkrOMRy/h1wTMVBMXrNePE3W6YlKhP0NwRomsv+wc9xC1uiQnzqwtS7/
   qEkMA1qgkjgv4DJ3E/p6FD6e/rUS0r0o0C+/jhL6SIpQQmpWrZX5FNiR7
   +nlC1iqtPpM/fPkHTWGIvne0SWGurY/1Fh/BtxV+Xj85/xLKoBmApJ7li
   raKJL3jU5fLVChbvsFNtH9QfDfeEjbNv8AjqrAcfs3LQa1FWg07Rb9uj2
   Q==;
X-CSE-ConnectionGUID: f6bWP+RdTB2R4rKIYbq/0Q==
X-CSE-MsgGUID: i83IH21dSzqN3UuLihN1Kg==
X-IronPort-AV: E=Sophos;i="6.21,286,1763395200"; 
   d="scan'208";a="139734722"
Received: from mail-westus2azon11012066.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 17:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdcSK6zvvQHArXuXv/JUGotEp6+AuZQOVD9ADl9PT0lMfaYPl8IDDP8/IkH3TYTgn9i90EmDX/kZQai9tJ7xOWskp4JyUjBFnPTa6Bma30IvoahSAXLI9Dt9pCz7u328FTo4c/eIiuaOwSApfbYB2Fwy2wRZs+bcydJJ9Wmqrqbge3XUnrYVkunS+XYrdWNd8QRziqYpF7gJNaV5y9xxfuNxs0MnzdIHyZi2NdCKIOQRxdXt41glelB4OlCkC2Kplu9IV++lQBAq/3VNmrBojlweky1HyPshzksho7rHFdAcQE0BTQSanr+b9kbcCDqDOhP65pT3s9RG0tFHwJ6JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfpHZVVkHg7UoOtb+WM8LaaZegcPePhAizOfUEdmQow=;
 b=Ic5vE82qwQE7tpW4dvyr+7pDLl/UfBYsMHS/MlyHXA3qMxRnfp+rtKmwSiBdP4EH/cVuhhJ2TK/mHrCiputi5E1HRKs5ZB+LYCUz6VvchlKiYY3cPNvan8UGHUPK3+hmDwYZ2iTgQCJDJyHK7qVHwn5VmbE286KJS53FRj5He8wDWLJkFlWvQ2y7CfpqswFndjNdwaXsMAZvQHbPwYFtNMBLrdycN+szpXnlqdK2frvuOuErAvD+7nUH7AYf7jLtkQZlpOUI/9YsovTaNUSBoNoN6HkPgJlvaVyuhKhpQNcdZVy3DJDfTK7qMcWewU12sVkpz7ewRIjy67k24E/nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfpHZVVkHg7UoOtb+WM8LaaZegcPePhAizOfUEdmQow=;
 b=C0J+Buv8WbuXKeaxpm0E3Y8ZOv3M/8x5SiGS5GnBVbDLD2CMGZ4/JB50MVJR9nZeDiyQwumNyNAqovCYnm4warK23t+cuvm4PS3O9n7nusOHJKEOAW9E5/va41MZiPFlrrzlr46BqWS6A325NgF/legWkXAup4KfLpat+2NR6C8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DSVPR04MB9964.namprd04.prod.outlook.com (2603:10b6:8:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 09:42:28 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:42:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Koichiro Den
	<den@valinux.co.jp>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Thread-Topic: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Thread-Index: AQHcmrjlBGBsUomurky/ojxqrKHQubV+0lYA
Date: Thu, 12 Feb 2026 09:42:27 +0000
Message-ID: <aY2gWHfq9NP8eQKL@shinmob>
References: <20260210181225.3926165-2-cassel@kernel.org>
In-Reply-To: <20260210181225.3926165-2-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DSVPR04MB9964:EE_
x-ms-office365-filtering-correlation-id: e3841db8-7723-4795-852e-08de6a1b08f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Joe3XWgluCq1pAtNPyFK2UKDQP5KsQpWqy+xQXzW6BuBgJc6jo3A7qFofe?=
 =?iso-8859-2?Q?QHVO6NW4SEabftgyVZAEYOfSLDV67mppMEH0jF/QFmRr5Dm/4ZklwgiXp1?=
 =?iso-8859-2?Q?OZaPzT3f/zjT3+UkM/5oiyd8jcM6hSrkrxMrCpv8GCl7g1Ia82UT3+BzTx?=
 =?iso-8859-2?Q?q059nvVS4cEY7pKz9/9202K4VbAl5n3JActKiK9g/H2/rtOvvztWHIBht6?=
 =?iso-8859-2?Q?HLVXOymH1nPVMu1IVW3EgXTEQNlW/CispKSN343c3gjQ6QGFW1V/CcUQcG?=
 =?iso-8859-2?Q?a/5OZLuP5IPJlZRIZ+ur5v7Im5tSqWNBXb3Gn/dU7YcA8cpLk0u7wTTBql?=
 =?iso-8859-2?Q?L87YQ6Xk/dcaR+JZqXj6OTT6NEj6Tf1DKKiDsflNQTVocty2lyRMSol9dx?=
 =?iso-8859-2?Q?4OYLpiFpEmFnOx/sge3soq4odtIsRZdQzv5AW/na9KDiNddf4Qx2wqbjRm?=
 =?iso-8859-2?Q?SMnvxh8h7EKT4ud4n+ww0LZKcQV+q5Ig0nmjOOZ1rMWEM7IqdWW1O7f/bZ?=
 =?iso-8859-2?Q?OLBmpdpozfCzHiCR1/SXTLuvgCUxwPZV9I0EE3ve/Uwf4mQwxFBUd+yL/p?=
 =?iso-8859-2?Q?/lwxZwysDmsaQBFJJHsbMybGoJXXBixfwt2k741MzkjMQ4jRDX33cdtqpn?=
 =?iso-8859-2?Q?4daPaqHfjjPySguKlguGhsYu7Zjy/oS0mMxxAV/JJQ7rdskin8SJLv/eS/?=
 =?iso-8859-2?Q?mYeSMxnTprO/iKnwMCt5n2qkZWRqH2rQvIJ8cZ2QrXN8egaYkiyRxzsxjS?=
 =?iso-8859-2?Q?296zUCaKjt/N0VLDE7UO/kwPd53JskM7VhJfiGDCNz7wWyiafZXvdSujo/?=
 =?iso-8859-2?Q?vW1U/CVKP8n/yb2nUTGzHkQ0ygzFGfQRQBrz/qlL9U596KehsUDI6gSSOs?=
 =?iso-8859-2?Q?BRcBL82bEuOo7wTlyx7SXzRknfpbK1ufQA6ONb3E3BwIhsjPcrDm2J/ai9?=
 =?iso-8859-2?Q?nnkxdqURrzYAU2TH3YcCV0xinDiRavX9EFX1rfHWqc4xmId/K0mD3ucGiB?=
 =?iso-8859-2?Q?KrehwZf5QROdgo8Y9EmqFz8OoBdxV8/6pDejcC+0d6owhoU/eG3pCUpJfW?=
 =?iso-8859-2?Q?EzfJaetzjHxGHhCt6SAJ3hwHgSvUOMvRChTDSisV35DpC05przGel4fV6Y?=
 =?iso-8859-2?Q?Gj6lWaBlvyvYjmWXd/k4TXo5wr1yln+CEm+7BlQGrWDvG/rEcDymvHgiEf?=
 =?iso-8859-2?Q?rBSHdWmMO2rUR9/PXOumWH2ZbbQ4/UrJNd61PBfaBWROaNSe0MIMs1TGRp?=
 =?iso-8859-2?Q?6WPeABqeXdkafJBlxAzuDQqOURpGj8FVCZkDfUtZobqMAwr7NF8Rl+7T6V?=
 =?iso-8859-2?Q?nR3xr+8Kprhxk0uNlHViE2sU+5oR6HYt85U7T8EnxVqaKRB2yaw+BWC6l6?=
 =?iso-8859-2?Q?FIv5wS3sFyZUYSMJOtyTpS2n/Iz7kwtURSJNXnomsHFhVIJ+AKZJIJWDRS?=
 =?iso-8859-2?Q?iW3NJR3mtRswlG+vASCp6zCfkjPxQwZA9ErSKJfXEnivD+mHPKseUlFQF8?=
 =?iso-8859-2?Q?J38g7ZPFIh/Pq0v3nt9qSglS9fUxbhBbc90bPL69AAQGFm2oMlKVaP4EUY?=
 =?iso-8859-2?Q?PCDQstvjFB+qyMgdWsiB9HckN9RwaeT57yvxp/+4hY4QPj7VIe1GuI019r?=
 =?iso-8859-2?Q?jBs2jJA+Zmt0Pcy1Eu8Alx5jIMKfsZZX+N4jiIaVIDWgeiJzLNpUuLsMXf?=
 =?iso-8859-2?Q?LHKl+D2AKdDXaz8dryw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?EO7dxzL8j9g3+lQa6hxuh9yyIKKgFxsBfvcgHriv7sx3ijJDaV6ztnWNg/?=
 =?iso-8859-2?Q?jiZTKU9YlCOB9VTinKyHs4JqheHkmEYk24uhI3c0Fyj9+EL/FGvr4PhU6k?=
 =?iso-8859-2?Q?W22/M+fJEAy57xwpyZp5Z9SweNsyjmdO7Zbk//LmuOT8U1qiW7niNnYXFi?=
 =?iso-8859-2?Q?/P5xjBXLjkaZqzb4OqS+Zv8lo/5ZOORpyZtwFFH5lzLyyCseL/p7ZQZI4m?=
 =?iso-8859-2?Q?zZCWf76LpR0DMM2Qq5lOLbl7wo6iCad3N75j09msNK5dN4oKoRsABdn2BR?=
 =?iso-8859-2?Q?65cM1lQsZ2ZQoiWEwYSPjSSHt+PvQA+lO3sy+r9uW/XXMX8fkSlylYhsIT?=
 =?iso-8859-2?Q?p5Giu3xQ1GycGh86Awq7NpVeqrwesZRSEF/9lJKqtdr3BTooUETkaxXhJ4?=
 =?iso-8859-2?Q?t4Q7XdDxva24XcXyWanPCDK4JpNUAmdZNp8tjpsA++xNZLEmNPCLuHZmw7?=
 =?iso-8859-2?Q?H2tN+L8bNfKu9s4UNcbhgei2LqmPb13Md1DYCFvffi1y7owD3CwtRPhhp5?=
 =?iso-8859-2?Q?uUSSSY1zIka3z2vaLMR2F8H7WpWJ7t3XjIUL2XTI+dGOiuOJ446UfB/LMV?=
 =?iso-8859-2?Q?+m/mmQNVGLtZaX6Zp+zdskr3hdCedTLec1bxCIJ1Qoa6H3XBZQ0TGA62+g?=
 =?iso-8859-2?Q?jdvrtFzovNIbT8Glf01Nl+rbjZCJR+Bt9UjCDEXLlcn/kfkF1JxlmN8PD6?=
 =?iso-8859-2?Q?tTVhVsw9F3LWUuVLb9lx99IKPsBJHxkpS3GLal/mUP5rPM6DN1fGdCys8A?=
 =?iso-8859-2?Q?3yqIMJNcLTkCR1HY7Un871dkNFIwvWWWtM7vuDNsu7LNw6BImMcVEke8jG?=
 =?iso-8859-2?Q?4Cx/znJAtloAbU4lYc4by2CRP1qihTTEnNrzbTjGi9lCOdOhQIx6hUsIvu?=
 =?iso-8859-2?Q?I5+/rTsrB5lmn5giml6UO33YmRQKuPUQ6AWtJj44PrvOpf/RKZyAxdfJuT?=
 =?iso-8859-2?Q?+XS1AACikNDodx6Z8N6DABnmUICt2Nu6L9LM38S/HNv6RFM5Pm8RxZdiGH?=
 =?iso-8859-2?Q?pf+EVveAMZxKx0vncLlW9V1RdQLLhsArRfI2vKWHv/jGQ9Z7JWKfxfcpKE?=
 =?iso-8859-2?Q?F/uHkQTrTsRt72u0ZYalUZfji4YatgjfKm38W08LPKn5b8YVv83KnpspuX?=
 =?iso-8859-2?Q?zzFSBV4XaTMB2GAJXej9CrFwhrP5K6mngA4wkLS2DXIYUTibYv1i2bR1bd?=
 =?iso-8859-2?Q?h+bKvNijuIkOWmUrey2DQyXN9Lb5gBep600alF+scCgd9a7rskOZ34y3/a?=
 =?iso-8859-2?Q?HMffir8uJpk5BhHe4AjyMCsPLjUCxfJAvbWWx7rHrZddu7qrbzUCJsGmX1?=
 =?iso-8859-2?Q?ruyMa9k0+V9GUQGx736Oj1MozeDA58Wdz9jSfMO+L0mo2KmibvvBO91ZHT?=
 =?iso-8859-2?Q?pPmXAISl+QWZcrQ1qQTsksRPJzARVB1pxMDQ+Zjz9OYSF6KdkB4r53Qgep?=
 =?iso-8859-2?Q?6KhV2PCM+56jFjkHIAGOIH0WPQaMmE/e8tKco7m9V2gUNhL6T+NFg0EWAw?=
 =?iso-8859-2?Q?6dy9DcReT3ExDrbOVppbCHx1malF4XFo/nQ6CrOhfYyQChwPppXX7hFese?=
 =?iso-8859-2?Q?7gAC8kUm0vbRBGCzcLm6aJ+kQePXd5UM/L+PW474JpCvAvufJ955b17zVK?=
 =?iso-8859-2?Q?5MQf3gRrSSCaBAQcIVZY8ndoKWehBqEBRH8uzvfxN0M/a/ygszzOEHHQkV?=
 =?iso-8859-2?Q?VzB3VVfQAJVsQxIMQjh8ZCo8a+4ZF/LhwhTnHxbZjUPJBmhiy1YNlHM2Ir?=
 =?iso-8859-2?Q?eIWiQtf3GG3e52fsZUOEBppuMfutxe07if2/6VwMDxRXEkm1EgqyUD8dpK?=
 =?iso-8859-2?Q?YRDDndG/TEBSsaK67YbvLpMl/s/8WKU=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <132307AD6E5ADE45AC1C1C0242D9CD65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	syE4UxffLVGG3Pa1N7NsmGwlnlIUm848sehYi9oPt8GxmKyfQvSnEU5s8+IuSqQghAMuLJf2ROs+TixjzpU8CxIlBduL83XFwp5SUW/i1rDazSlAVPxqzUDjeg/XsuI3qE2Yb3seTdOJJMGHyojTWoF/aJ/crnLDtAG+1UqJON2+Naioz/Dwif5ixIyMemmJ0LA62n1dIiRSB+AfJR2X3ntzgcbF5/vmOGt2VIs0q8SIDSLnKVIKo8B6EngYXIhwNY3PkJdOqKoL/qSZkxLJZAv7Yo0rr7g1JYVtmBlMQjN5r3+cOSQhTRP8W8wRzgpSYrHk9+BnKVYPScFSpAp+Q4+VpDSZ+FaPxvhvOWL5HHRj70DoHFjU8oc5NkMuBKe9T9Oh4q8/h/8MndWopZMh8nUzXWN5ueoz039a9samIEGkXFOuVgzmbqPjCOY8rarv/WpA6b+FVNLb9bY+A6A7+gD60ys8v/5CNAhL7x3gViZNR0Kad3Mv5akPR8j+0q3+Q0lhnhyjU/joJJ6ydMMK9t9qz1mRkTWb5V9i+uUoYheWogA4vAw2CUajyz2fM72pjSf51RGU0UvxKSd1qPqV/opqppi9z2fAVErpyUX9Gwra1Gn0kBl1yaUjCHfHgnFp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3841db8-7723-4795-852e-08de6a1b08f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 09:42:27.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5y4pdyKrAbRJ0Qy/FXPcbhFDGNew0xfzLYYvV5lfUHY4RcrGngTf1Vo5BV8rj84xLNWIJYjBe57mupsLKLsQ0iAhSiC2Kzr2Ugs4tFDiqsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR04MB9964

On Feb 10, 2026 / 19:12, Niklas Cassel wrote:
> When using the nvmet-pci-epf EPF driver, and starting the EP before
> starting a host with UEFI, the UEFI performs NVMe commands e.g.
> Identify Controller, to get the name of the controller.
>=20
> nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> Completion Queue, and then raise an IRQ (using
> dw_pcie_ep_raise_msi_irq()).
>=20
> Once the host boots Linux, we will see a WARN_ON_ONCE() from
> dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> because it never gets an IRQ when loading the nvme driver.
>=20
> The reason is that the MSI target address used by UEFI and Linux might
> be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> return -EINVAL.
>=20
> This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> outbound iATU mapping"), so this is a regression.
>=20
> Also, remove the warning, as we cannot know if there are operations in
> flight or not, so it seems wrong to print this warning unconditionally
> at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.
>=20
> Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Niklas, thank you for the fix. I confirmed that this patch avoids the
"WARN_ON_ONCE() from dw_pcie_ep_raise_msi_irq()" and the host hangs in
my environment.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
