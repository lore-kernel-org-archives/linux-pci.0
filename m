Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121A28727F;
	Tue,  3 Feb 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140613; cv=fail; b=KZ6CpJ8VZU80fD4uXWbHrS3YZSlKrcoaCkXo5aZWxAAebA3FKuFw5h5hH7kPGzZg65/VwT+p/NhHALLoUeNm8hoGKPxEzjN4fvffLuAshivKb8Mrmml63h+2Ic90a3nE3lK9SuM8Tre7UG3/crxUGq9c8+V+etDzyMaYw20znMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140613; c=relaxed/simple;
	bh=2BmEqpP67jGfBTf1MrMm+pPx2tlBorGLWteTCkT4n1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rdd9QvRhMOqkvz1RdGGJFxWd15dS8UEeqbPdzxevpFNm31Y8W5lil8lh4gWDmO3o5ZCRZGk71a/we1cGYImvDIYxXEDkZbrSKU7ZstNdoE1TkqCXNW7HGBgfgqxiP7WeQHO7aq5NCunv6b3bLqUnMc+ORMnqLCfChUWP7z1EZps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T9UqPi20; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9UqPi20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSYR4kUjSYB0R1b1sUh7fsu+nXeHa1rnqOj1H4jRd8TPR9b8RoloU3JWZYC7TMFkB+hCUyMJx6QKqCFjtJa99HCRH/IYrloMubhGSlk2f3FGWA5i9QsUMqFXWtrNYPmGzmUXWVRfldiGYDdU+vxfGLN5t8418O1f63UGxeM2fW43QgiKXqbGuQ3q4bKJDkvfyZcz37Y5VQtTibcP7vtkY8Vj8twILUxUpb8NxvTN9TB0qwb4QiAy161+Pfure5gyGFjjMu/wPJdDdKAiz3lDIwSi9VFMuSpYcmdZCnScbKFw07OfU2FQ1Xj1LJVeiVvc7dCXcQtBx3dtQ+1id9O8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz4cLTjKrRovTURdIWnYGeoOQd7GaCY3cS7BOXfEgHI=;
 b=TgfzPHqCHQCkHQFSwO0ux1jKNaRbNgA/bgQKMKFJtzPqYLWvfiXQWrbvwyqbBISkllh3wnkMPK5RrRA3VJyW5lleOg5VNhilsxY6s88Tk7SK5yL2rBt+0a8zGPmV7vkBbjDFsdVCS8erlBAD6Vs9Z/3Vxlhv1tnhkrEd87U2XybNgqr1y+fjpzHNd0TT+veSnrJhYtR5nyT+V0JQCBqOgfFmWJN3+hMHvcjU/4hRhMsUmMzN9NLzcBODKxU1D8guZ5NhraKZYyfzx72nbf/BiwZSBRamx7RD4G3todcUD+ybAx6X4jTFtbWjrDMYPOXmzEVzQcFMgPbbj745bG5vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz4cLTjKrRovTURdIWnYGeoOQd7GaCY3cS7BOXfEgHI=;
 b=T9UqPi20z27KAUA2FKyo7UGzyJv0gLhivyCUvX1TDRqbUtKu8b9mykosov0efNpJ37R+WXpn/7OCZxGSfj8zlgR5sELQSU+99bff+4yj1/Va5hQu3tcFljom4LcjPTHCvbI0VX0yQaDMfShP7ofmjgfVBM3qF026dau56n85c3lIUUVW6nptd+lOtCERkQcD+YF9ikB6vOljaVyOPtR1444ZOBzS3aT31bPfrr8z4iOV4KWNqouGUPoKuPKrACbXlbRE7LcM0VYrg3l820PSR8qZ6He024o4Mm6r0hMIVHodyd+DUklALlr0t6SjjuUnoUyNwaMyRfncCQ2A9+6r7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB10018.eurprd04.prod.outlook.com (2603:10a6:20b:67e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 17:43:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 17:43:26 +0000
Date: Tue, 3 Feb 2026 12:43:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <aYIztYs/07WBLsAq@lizhi-Precision-Tower-5810>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-3-sherry.sun@nxp.com>
 <nekxn5osukwkumqfh4qabj6okhtv4tdwrnthza4x54psrhauyf@p3lhia4mkhb4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nekxn5osukwkumqfh4qabj6okhtv4tdwrnthza4x54psrhauyf@p3lhia4mkhb4>
X-ClientProxiedBy: PH7PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:510:174::26) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB10018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba2041e-2b2c-4c14-7850-08de634bbbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhKR2hSZ0NBcTZpS01mYU51SjY3ellEZVBRZkJrN080YjFTdTUwT256RkZ3?=
 =?utf-8?B?d053MW4zVVFyWVNsWUd1VXFXck5GRzBLTUxvS0Iwak9IQnVOdUNBRmozaWpj?=
 =?utf-8?B?ZEtEM3B1UGtVMlZ4RHFQSTYzczhUVG54R0RaMVpjTDRVNkNzMkYxd2lIdUdV?=
 =?utf-8?B?QndNSmIwVE83SGprdW53VGo2elF6ak9YVGxrQnQzUFQrRkRCQkN3cnpPYjVW?=
 =?utf-8?B?c2VwSVhBUzN2eW4zQm0rTHJMTnpzN3dCMWJBbDdzSFBBV3FEZUF4Qzh6eWkv?=
 =?utf-8?B?U2Y2Y2xBNXhMdFN1dnBxaU9kUExUb0ZsRk9IQ2pJUUFjY1pMMmViSDE4ckt1?=
 =?utf-8?B?YWxGMzRSRWpwcmVyOHRjZGJSTGpIeXYreEdtbkdDOEV5Sk11UjNkbGNyajNI?=
 =?utf-8?B?dWFSN1RkUk5seTV2S0F1L0J1MGNiaytLbVBkam9kOTljSHplK0xGN1VYcFdE?=
 =?utf-8?B?T2thM01Pb0F4dkphemZ6YVhOMlVIRTRKeEw1TFk3ZWxyblRMcTdvRTlyRlVz?=
 =?utf-8?B?dUhBZHg0QXI1M0l4SUVadGJ0Q0E5TUJleHpYa05GY2hjdG9XcVNDci9WeTFu?=
 =?utf-8?B?cU5ZV0M4RmxUNUZHSDZ1WDYrc2JsM1lTaTdweHZFVkMrS1dEeWpDRk4zeXIx?=
 =?utf-8?B?MzV0SkRRaW51MDdacE16c3NrWnJLVUZCajdMc2J5VFhyYTJCNnY0M2Q4azlj?=
 =?utf-8?B?YVNJS2EwalJvOWRZS012UXpHU2FuejZYdTVDRWk1cGhYYUgxNS9sM0pEeGJQ?=
 =?utf-8?B?aXlKUXFOcUFVQ01ZQkZOT0lUK3pWQnVKMmhieWIrNDBBSEpQZGxDUkd4K05B?=
 =?utf-8?B?c1JmWE5oVElaKzlGajhONEVteVhMdUlJWTdCYldINnZzQWx1VExHa1BjbVpO?=
 =?utf-8?B?K3d1VjBXNER2dzdHNHNWY1ZiaDdDcWNkZnJBaXNIVHZ4Znl2RTFYVlM3NTBK?=
 =?utf-8?B?TkI5ejNCc0dCbisyNDRjYVNQSHlDa0E4WERpRUtPclRkdTRYcEFoYU11SmJ5?=
 =?utf-8?B?aWF0eEZHYi80MU9PYS9QUk1od3RzQ2toZlVWUDNPMlVFNE01Y3dhUTlaM21E?=
 =?utf-8?B?RTZYMnF4YVNqSWtQdEFPdXZ5b0h6VkFmK1pXZFdVdTBZdElxSjBjL1c2ZXJl?=
 =?utf-8?B?akJwRDA3ME5iT3J6QjZYeWZORER1cUJ1N1JncG9CMHZvTFpxQThaQU13MmpP?=
 =?utf-8?B?MjFqYU1pcXczTVB1RWhueHo0Q1RMdHdHcXJHV0c4OU4zeG5GL2NZUkNoSzZq?=
 =?utf-8?B?cURITTFOdmpTQTlzQ0pkdEVpRG5Mb28xRGVlWWhzbDVIenFxOE05YldpcVZJ?=
 =?utf-8?B?RTBCRXZZK3hiaWcrQmJoZGJLVXc0cWl5SnVZdC9CSlRZcHBQT0NCaEQybDBp?=
 =?utf-8?B?VUFNbzVMR2tnQXdraGE2eUk2cjR1TE5qTzdaM2tLUGVCWHBUcmtXdWI1bDEx?=
 =?utf-8?B?OENTc2I0cTBjUGxTSzBxQUVmVVcyMm8yRXNST3hGRUJkVVpsb2hCU3ZqeUtw?=
 =?utf-8?B?cVErUnlobHd2eUVXejBTbVZOZEJvcUpaT0s5ZnNwRXVlUnE2UFY5dFdsZVhZ?=
 =?utf-8?B?ZnNjM0VxUkluNnlqMWNEOUUrYmNDbTJ2NG0zQy95azJzZm52clRXOXV3dnZs?=
 =?utf-8?B?Ui9laXdzSU14N2JyNHNpSHRCR3RxeEhOaVV3WGs3d1g4YTYzSWdRd2tQOUk0?=
 =?utf-8?B?QThpMldJb0dPU295TWswUEN2R1RNM3JFV083Ums3djlGZlphMzgwd08rV3E1?=
 =?utf-8?B?cEJlNkphTDhqamFsamJUamUybjNVMXRpa3pCUlFUUWpQaTU3LzFXckNZRUd5?=
 =?utf-8?B?Sk5RNWs4N3lNU0Zvd3VVZWRNSE02Y1hza1c5eTFPQVk4UjVHTTY0ZW03ejNH?=
 =?utf-8?B?bnM0ekpzVEF5MVQ1QlpUa0J3d09WdWgwcGVTbmFuRVZrY0pVeks4NmZzNjgx?=
 =?utf-8?B?ZEs2ZXBKWGJRRjJ4MmhZZ1JGc0xuWWVqcW0zaVBYTHQzRXVINFNBRTVzNXdp?=
 =?utf-8?B?RU13QmU4WEdQd0UyaHBrK1hBekNmVE9JT0RZTlViWE02aHhvRlJ5SlMrRU1j?=
 =?utf-8?B?WkkweWlXcGJVcUlFU3BaK0pnZjlGLy8yKzcvMVNyUjFlekdmR1JocVV0Vmpx?=
 =?utf-8?B?TjBkRTdBVEJicVZkZEpCYXozbGxqbGNYa3E4MUFYOWFBenUxK2dXTUJlcHNr?=
 =?utf-8?Q?6N9k/zzb5xyaOpLVYgGLwg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnk4S1ROSVMrZGIzSnJ1Qmc3b21WV0FEZk8vajc4bWZQZlBpb2ZUUWZ0T3dS?=
 =?utf-8?B?TkppZVpjZ1FjWkxzdDlzM1RCV0Fic2xEckdpU2tvazI1OHR1bEU1VGl3VlF1?=
 =?utf-8?B?NGIzM3pBeVRkZkN5V2ptNmw5aHdTdGNsUDg2RTVUV0xDL2FiNmZab29UMHFi?=
 =?utf-8?B?Q21XKzNrcDh5c0VzYWxYK0gvY0JrdDVOclVGcmJycXhJMk42a0RWTjFkVFBu?=
 =?utf-8?B?MFRrR093MGZseThSb2Z5T3lwK2NJNlYybU4zUE14dEZ4alZuWlhrQlhSc0Ir?=
 =?utf-8?B?dXQzQTN5U2gyNDJyTUZUWXU5TEc0UjBmK3JlY0J5QXA2VXhLY3RHdmRKMnhr?=
 =?utf-8?B?TDV5YTFnOGVDRFNRZU1HeFhBUGJ3L3pKY01rSUVSSXpydU1yMmZMbmQrWHpH?=
 =?utf-8?B?QitzZWF4RklkUHdwMGhneTFxN0J0WUJydGxEZUhTV3RWc0NVQmxNQnN0bkJs?=
 =?utf-8?B?OENWUmVYZHhOMStMbk0rTVlsYXZDV2pyaHRvVnpvcVY5S3NGSUYvYnRwM05S?=
 =?utf-8?B?b0NMdlJXUE9aWExvTE01ZUprN3RWNk5aVnVCNlJXVVJxbS84SXA5TC83MlAw?=
 =?utf-8?B?NUh0UEZKeWhQekVtU1lpYkF3Tzl3V21wSmt5OTZpK2FibmVrdFp0OXNHWjJN?=
 =?utf-8?B?MUNJMVhiNDFVRUxvcCtxVzltbkVHbmFQdTRNSTlyYVNMNzlQcFNVTUhzcWU5?=
 =?utf-8?B?K1JxMWtEWHFMdEZmMFhCckUxVXRDWkM3c3VNZnUwQkIxb1ZPZnBNZFlBR09S?=
 =?utf-8?B?ckpNU3pZKzZsRXFHVG0xWFdQRWRnWXFTOG5pRXRlS2ZBMnNQQ3R1dG01NmZ1?=
 =?utf-8?B?em9UU2JaR2NxK21CVDYrR2FLaUtiRjNZbXoyNnQwTUxJcW5MejQ0QUVIU2Ft?=
 =?utf-8?B?bTVYQUVuWGlwNXljTmtnMTZjYysxS1ViYkYxN3pHYmtmYlRCc2VmdkZDU2xE?=
 =?utf-8?B?UjhrTnlXNGxuSzNKMG44TU1wVlhTMGYvMWE1cFJRMFFiVGNELzkzMXdPMkVO?=
 =?utf-8?B?WHI0bDNDSCtJNldzQ2YwaVlGdTlRK0FCaW0wb3Z6U1poVDBNU3BHdjBPYXZK?=
 =?utf-8?B?ckg1cWdjUU9ELzI5Ykg5SjZqYkpEdytLVGNyczhNUk4vUDFEQURZOTFkbG1y?=
 =?utf-8?B?eUlFbUZtbGliTUdiNFNMcEhnYjd0R0ZyOFR6ODUxUERYV20ralFlbjQ3aXJH?=
 =?utf-8?B?elBqS1BaNDNLRk1sWGE4Q0dUKzBreDI5dVNCNENmNUdQTk1FdUtFYmwwUjRk?=
 =?utf-8?B?UXFIVWhaNXBsRWduYkx5NndiNWoybkFUaGp4aTM2VFlzMUxCY2dyVTQ2aDNM?=
 =?utf-8?B?MlhJVFhlZW51akhIOHVBTkhEeW9EZ1h6akt5Vnk0QnFvYzYrb1Jpay82TUFx?=
 =?utf-8?B?bnJaNnA5UmdQL2hmN3AvUGpFQXVNV0VYc1FtUUpSUi9YK0JZTGxnT2R6NUsr?=
 =?utf-8?B?WnBFYkZZZGN1VU1KS3N5bDZ0V1VnL0xScldFTk9ROGxSd3FSRmR4OG9qanB6?=
 =?utf-8?B?ZEF2Q2RCY05jdVAwRFRqcFJuVDB6dE1ybzVLanlZaDBKTTFPUjRyOXl3QXNU?=
 =?utf-8?B?ckRmb01MMXBQaiswbGR6T2ljQXJPVHAzOTJaaDBQZXBZdUNnLyszRU5odzJN?=
 =?utf-8?B?SUY5c3BCVXEzVjcveXQrVnVMQzBteWpybDJYdnRESHJENUJhUjJwc1psTEhZ?=
 =?utf-8?B?OUVYY3E1ZTJIUVZrdms1WU5wR2MyRXpzaGppT0VrY0tTWnRjbTdodVE5TGsw?=
 =?utf-8?B?UVNER1Nndk1wcTIrMTIzczhSSEc3amR6aDlQRE43OTlkbEVYNUVoVXI5ZnV4?=
 =?utf-8?B?SkhvSm5tdThoOFQ4d1R0MzRWdDdoUE1YODNEZ295TlR3REpYekxPbUF4eTNE?=
 =?utf-8?B?eG5kYjBJVkdwT09kMzlBQ2xyK0dQdGw3bnBidlR4V0NnM0lncWVSQXgwSXlF?=
 =?utf-8?B?NVRIbHMyU0h0ZDVWMk9lM1YvajNmb3kvazhVMTZMbGk4bVFsMzM5dkdVQW9v?=
 =?utf-8?B?bjZseWdRanFtZWVKZnhkY0M4RC9WYWVQdmhYNkxFRVptY0V3RE1RWXZXOWsz?=
 =?utf-8?B?ZkxLSFpiaXIyNzFVaGNwamYzc2Z2NjlnamUwVnpyZXBvSnlHU1Z2eE1TY1lM?=
 =?utf-8?B?c2NEMG9JZzFFeTRJdlVjaGRndjBCNW14bWlacElTVzdhbG9qaEY0ZmUxZWxn?=
 =?utf-8?B?dEE1L0NGQlRhR2R6RnZLN3RJMzg2a3NkclJsRjE2dGZJYlVpd2ZWelhOVWtm?=
 =?utf-8?B?bmZobGhCVlpJa0tkOUZ4dnE2VDV0aHhMbndmbkhNcHM2a1Q4Vk1ZUjZ6K3Bs?=
 =?utf-8?B?OXVQSDBGY2NSbmc1eittQ0YwMkZkYVIvMmtRb0gybXdOcVU2ZjlqZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba2041e-2b2c-4c14-7850-08de634bbbdf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:43:26.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gJWUc11hpQS4bs4lGpJ3wTlOx6GfoIq2jWRfDK9/9ZEcigAgvt7wVQ5zWhkA5RHKk9ZqC25JclEEJClQ3RwpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10018

On Tue, Feb 03, 2026 at 06:38:18PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 03, 2026 at 09:56:06AM +0800, Sherry Sun wrote:
> > DT binding allows specifying 'reset' property in both host bridge and
> > Root Port nodes, but specifying in the host bridge node is marked as
> > deprecated. So add support for parsing the new binding that uses
> > 'reset-gpios' property for PERST#.
> >
> > The initial idea is to add the PCIe M.2 KeyE connector support and PCI
> > power control framework to the pcie-imx6 driver. Since the new
> > M.2/pwrctrl model is implemented based on Root Ports and requires the
> > pwrctrl driver to bind to a Root Port device, we need to introduce a
> > Root Port child node on i.MX boards that provide an M.2 connector.
> >
> > To follow a more standardized DT structure, it also makes sense to move
> > the reset-gpios and wake-gpios properties into the Root Port node. These
> > signals logically belong to the Root Port rather than the host bridge,
> > and placing them there aligns with the new M.2/pwrctrl model.
> >
> > To maintain DT backwards compatibility, fallback to the legacy method of
> > parsing the host bridge node if the reset property is not present in the
> > Root Port node.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
> >  1 file changed, 109 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index a5b8d0b71677..e3ba68976bee 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -148,10 +148,15 @@ struct imx_lut_data {
> >  	u32 data2;
> >  };
> >
> > +struct imx_pcie_port {
> > +	struct list_head	list;
> > +	struct gpio_desc	*reset;
> > +};
> > +
>
> I'd love to abstract the Root Port properties in a generic struct so that we can
> introduce generic APIs to parse the ports. But I'm not asking you to implement
> it :)
>

good idea, where is good place to put it?

> >
> > @@ -1688,12 +1771,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  			return PTR_ERR(imx_pcie->phy_base);
> >  	}
> >
> > -	/* Fetch GPIOs */
> > -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > -	if (IS_ERR(imx_pcie->reset_gpiod))
> > -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> > -				     "unable to get reset gpio\n");
> > -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> > +	ret = imx_pcie_parse_ports(imx_pcie);
> > +	if (ret) {
> > +		if (ret != -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
> > +
> > +		/*
> > +		 * In the case of properties not populated in Root Port node,
> > +		 * fallback to the legacy method of parsing the Host Bridge
> > +		 * node. This is to maintain DT backwards compatibility.
> > +		 */
> > +		ret = imx_pcie_parse_legacy_binding(imx_pcie);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
> > +	if (ret)
> > +		return ret;
>
> I'd prefer to do it in err labels.

we just removed err label and module remove.

Frank
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
