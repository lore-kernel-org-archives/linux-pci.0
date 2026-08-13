Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33962737FC;
	Thu, 13 Aug 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645977; cv=fail; b=JdI6Y6wjdkXeF6Y7SnCF+iUUxnRPtsH3pfBR1+9Og9Fpy+nP5VWv/ElUyq2Y19oOngXmBPou9FKw+aNgHPEytOAZAtigiMZb4cj7t3gjknMeDPF4jzafa1F9aYZDBAujiGfFr9dkQZigtoeVWpTKBh3E7+ttbw/fkCXG+Nl8hK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645977; c=relaxed/simple;
	bh=8exkbTQBBW11EBWOVkp9DAaxxSKtElP/7NbD7d5My4c=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=BT2oeH7Ra8kKz7ThHE+eVluOXJLTlmWuQEnQDfXR6HNOZuxoePKBRnMB6faXM45ygfmqW7S4d497nlt0lKzdqG1sE89LOI05O1ViZrh1t/xW9VKDJfsCjv4P4J7BKX0RQcyY5HDPDPmtnLLy9bLCUjxAOqsfXsP2SGdg7TAlqVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=T+L5hEas; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=tV1kbFG7; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="T+L5hEas";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="tV1kbFG7"
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.7/8.18.1.7) with ESMTP id 67DI7oDj021821;
	Thu, 13 Aug 2026 11:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=02022021-podllnl; bh=yo12AYQLxcUe8+8
	I/YsR/5ii4LkhqWYwvuoFYRSWG1k=; b=T+L5hEasEOclda1sCBlJ85yuD+d/dbd
	lbaWFO6Ppk76PFC3dUXbLhywNvzWHuspLFga95pQUxPgpRd7K6Gqp+2idGo2/Kn2
	5o3EnNq98RhNsqH0+jZvRIbs8cOf2u5bMXcHUN4/cxvJQVXk+ZuzP8RBI3JxTs+h
	OtzlWVcDxZNjOzL+a3HAL2XIZnR4pYXJh/5sIyksJpM43Mbux6jJeOSoyhmiTGmQ
	kICtlC12YflYDRpiyzoPSAlJk/CbarYAwG+3YmR9bIw0x8JU5tgh/18l8eL3djQt
	wSXHb6pKvyLokZcXhg0gfLs9fuIuCESmwlqXPydCaLP4sbwjnvjC4JA==
Received: from bn8pr09cu001.outbound.protection.outlook.com (mail-eastus2azon11012001.outbound.protection.outlook.com [52.101.58.1])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 4g0y28sxnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2N6q+zGJUGE0iTx6T+7zvWZz65bCuC3t4jly5aNWw3FyurUOgx/X0eXZnFtLy6csnsC6VYUA+vd/T+hanKcScbmVUMGziDk7iLdjJ2kNkURmLP4W2hS5XBMrLbuKDR9fOngVKqCgEgKmCqBs9/aWB9X7LfByzRljgkp+CViv/LuC7ExMV7k8I0sPUasCBlVzI9hrcBwM61EvzuaGuXcv4SbPLChltnywOAvL+RiCnXYGxsDzvtCmAsVkgAJOauLtFwCxaI1o7Jr0yXwzK4F+54N4OqeVobA1e+9uwgOlKgIaedGxxpf2WirDpjTEIGyF/9XZOfZcG5JCVr2B4LrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo12AYQLxcUe8+8I/YsR/5ii4LkhqWYwvuoFYRSWG1k=;
 b=vdXYvGWrg6Zy3Naz514wTe9Sxic4nYMqgpfBCYQiBYYb+7ShvvmFvdbszJdBGIPTein5lqjXfs7M3N86iiyaLEXwEfO9VnJ0+PWQdeMkyZJDXD8iVhqbjtrNVi+WjQLVIKSs7M1cKh5klo/McM/1iwWkwzir2GZSOvki8MrSqNOvs6wHAzYY65gs8u/6YXV2Ofg7Gq9OQV4+UYhDVO30CY0RqckCJPZzTSzIRlu5nLNarCP2I0M7iPBPuwCsh0ZhP0sHVQCM5nYNlo9k8BTvhh/YX+W2m8UsdxDzi8RF7FDSVzlq5hikJaScRqbLek0jE5NmP6Iful4VqSPhVFgYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo12AYQLxcUe8+8I/YsR/5ii4LkhqWYwvuoFYRSWG1k=;
 b=tV1kbFG79M+W4LdrzFkTfl/UFUpxywGcI25VqGcnbZm8kNl15zNE4tPus5GpIvs/0C8T9stGtCU8p25P7oFSczFQdiAns9t7jIiNNKZ1imenyxpaWQRqY3Ij015YRpY+zhWRFCxNiJIdWtABIGK3JZHO6k3WRMxQsZt31aQhWZM=
Received: from SA1PR09MB11481.namprd09.prod.outlook.com (2603:10b6:806:372::6)
 by SA9PR09MB4639.namprd09.prod.outlook.com (2603:10b6:806:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 18:07:55 +0000
Received: from SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::e01e:c29e:b1a4:697e]) by SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::e01e:c29e:b1a4:697e%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:07:55 +0000
Message-ID: <483ad5c9-351d-45f2-a8ef-04a717e97545@llnl.gov>
Date: Thu, 13 Aug 2026 11:07:53 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v8 RESEND] Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: corey@minyard.net, alok.a.tiwari@oracle.com,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org,
        linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SA1PR09MB11481.namprd09.prod.outlook.com
 (2603:10b6:806:372::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR09MB11481:EE_|SA9PR09MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c8ccd4-cc2d-4187-a858-08def965cc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|18002099003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	nr8m3Pz1JhZEQgmYap+8vC4CtBZkeV5Z6YBUaE6m3mNfuNRVK2b93WuIqfO8BabJDMww310dsDjG6E8kdEU27vW4KJPSSSfgjz4OX8OcbOFtsRNPPlLCR2oPItsHBhw5aZg6ThOh9PbVCt+D1zM1oUa3E1xj/oKAmnqMoJhu5qqZBdOPu103BZej9P6pb0pcZL82B+ySDdVrrC/B+tWddzMtPeJl/oVbvqPVzKqZAj/X2kYnPoWj9BWKacqyoC9h1k8OtMlZBMz+aQxfZtjVq4IW+P7r5lylG1HnVV/90lwCrKwby2qjkYzRr0RvArzgXtEFcbSH6r6n3O1jNX2jo1wTZc6kvRLxYYKzBjSTIRA2pZN5lTnB2/AU2xS+gHnQmA7ht+3T8/C/jWXt0netHoHjOlErQwKmhexPwJ5s4RnpQWb3Rm02qxe8l7sKOeLtizhk0syra4oF/rxLwUWb2bRhxF8FHSJcOhDSBOE3fVC/shx8dyVNS3v3ALl5bEU96o51qsJG4No/jkX8werBHzBs93XgF0mwNiDlUwS7C1O6Yak74E7eZZ9XpABKHGLTazkBCBMedlbEwx9bTQXzHIJ9op20MSXcJNRcVQkub65Vjx5t6Ug78PHY8xaA/+lzvFkPIJZcHA8wNfIEb9ZWg3gG1K71O5LCH34bJYSXTYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB11481.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWlrNDZVbUNtWmhnN1RmazhtTXYzZ2dRZ3JTMGpZS1czRzRMaGZhK2JDbGsz?=
 =?utf-8?B?YXk2MDRPQkhBQThVSUFVV0dvQzkzNXVnT3pLTVlOb3lJRmRvQTZJUDc2eHRy?=
 =?utf-8?B?UlkrdndyS3JLZEN6dGhIQUFTNkJVcFd0VHhuVDdoVWRseXhsd1hJVnlnc21G?=
 =?utf-8?B?Slc3ck9aVGFGZ1poZktMS0Z6L05NdSs4NkJLK0QyMGpZQVh1NVVwQXp5eXo4?=
 =?utf-8?B?dmJxaUZoZnN2SEVaK25GYUR0dHNrbFZTazRxUm41VW1ibEJ1aVBMdXNCdVlw?=
 =?utf-8?B?WDk3NGJmajdOaXM0a00vTUdOMUR5RDhsdTRRcEU4NHo3Vk9zU3VXVlhQMnEx?=
 =?utf-8?B?MXo2cVh6SmMvaFg1UXovOU1pWFBudytMNFR3VWFBLytpK09zemliN2t1SU1o?=
 =?utf-8?B?MjMwL1RQbXAwdWp2VThMN1ZEakFYWXFPaEFIcTNsbzJaTUtwT0xRSmo3Zkw4?=
 =?utf-8?B?all6clVQYlM0aTRQQ0NZeG9ra1UvTHZQaEc5OUUzSGZhendJeEZZNlRCemVw?=
 =?utf-8?B?UkFmRTR6VUpja2ZLaVZQeTh4QnVIbVVSSmV1b3NBMWtWZG9yOFgwT2dKemtP?=
 =?utf-8?B?ZTVWNWh5K3ZsUzcxN094NnkrdXo3aEZJY2RKMXE4MEtxOHpDaThXajRsNTg1?=
 =?utf-8?B?Y2ZWbFY3RmRDUGlZaDhqN0NScFluN3FWRWNUcWFYckxIcks2UzZvTlptZVVP?=
 =?utf-8?B?d1h0VlRMZ2FQb3Myc29ZOEUwSkVwWjJXTFNJNHFrWjRaejM0YzdCWmhmRS8z?=
 =?utf-8?B?WnhHTmR4Z3ZHQmR5dkxGbXZYeS9aMEE0UjYxMEZkZU00czh4UnFHWjhNTkFE?=
 =?utf-8?B?TXF6TCtqN3NYdzFHN2JzRitNSVlkb0ZpWmxQWkNPdExKL2Fnbk1hcEx3UkFS?=
 =?utf-8?B?bVFrWkF6RGsxTzN5cG1GQkRVTXptR3pCdW5UY0VtenplVDdlMm05eWlySGZ1?=
 =?utf-8?B?aVFlQ2J1NndSWVhXbjlIMnhJeW1hOTZER214TmdMdHJXQXJCUjNOZ010cDlE?=
 =?utf-8?B?S3RhZWl5SzdGNEw1aG9nTmlmc3VqWllBVnM2b1RBQkoxd0trNlhVNTY3S3ZU?=
 =?utf-8?B?Z1FBODVlem5BK3pZRE1nYlZjVVVFSFo2N2JZTmRybHl5N1VsMnZqejYyY2V3?=
 =?utf-8?B?MDB6WmkweCtFa1FiTGJkU3lEUjVRelVwT1hLZ2NsVVJNNDlTNCtRQ1pZcEZa?=
 =?utf-8?B?K2lQVk1ZSnQzODg2MFoxSEM0a2lxYWdYV2p5emVFM29qWFBNNG5WNlJOY1F6?=
 =?utf-8?B?VzBtZ2YySUc0VzN6SG94Zkp5eXZZRmFkNEcrVnFaaExPMFhRR3I2YzB5NEJy?=
 =?utf-8?B?Z1d5aUZ6a3RqVWVVR3M5dFhqMzI2eUpPM1A0VlhPMk1sMmxnK2xBVWdpMzBs?=
 =?utf-8?B?bFVQYzEwY2srdkhVT1JEREI2dTFaemJ5RnFDejV0MVo3eHA4ak16SjRCOXNC?=
 =?utf-8?B?ZkFib3RnUnJmbXE0dDh4TTNYN3pmRnZESG1zTWVqblVkRWlIYzhDeFV0Rnpq?=
 =?utf-8?B?S1QwckVEcGhjcWdrdjZ1cGFqRVkwbVZNTVFVZGxwaDNkMW1HQmI2TU5uQjlU?=
 =?utf-8?B?MGlTTGdXaXRKQThoZVQrSjMxTEdFNlI2dGloMzUydzlDU0x2OE9UK0k2T1Bt?=
 =?utf-8?B?QVljdjhTd1JEVnFMaGZ6MC9QcnY3YWJtRGV6ZlZYYWtVVGc3ZXREbDBMdWhD?=
 =?utf-8?B?dEUzbTVZQjhsMmduV1UrZU8rYTRTTDgwYjlOZExyZHkybDZDWE9ITGZKaTE3?=
 =?utf-8?B?aFUxUHdvNlJnaFRkeFZrVTlkdFpkZDZRR1NiTjA3Y2trNXFjZ1NQZndJZnRE?=
 =?utf-8?B?T1VzbFQ0UFhDNzlqMHVmREtkcjIvelplcmNrMktUUDJoQVY2VGNtT0ZOTnAy?=
 =?utf-8?B?KzNLSkNsbS91VWFhZXpVQ0wycUt0Y1ZaY2xFTC8wV2FJRXk2TVBPVng5Sldp?=
 =?utf-8?B?dFlwelZWc3BLU0FGanV3YmdvYys2cEV6QUR1Z2REV3l0OUVaOHJoM0ZMblhN?=
 =?utf-8?B?TlFzcXJ1MGd5bXFDMkxCbzdTbTMyY1M1Zkd6cnZHZDE4M08zM0ZYc0F4VUJ1?=
 =?utf-8?B?UERpaGYvWHZ4eFRXSnBCR2UrSVVhTVRUaWsxakNGV1h0ODRXMW5CVGJLQldJ?=
 =?utf-8?B?eG03REZQbHR5aXdVUHFvekFNYkdHYjFRR3JHblZCYkV5dVI1QTlRMEc5WEhR?=
 =?utf-8?B?UnJUQmZxZUNEakVzenFPK2pWQnhNMlhnZEVSOEZhamxEdjNEVUFJeVM2UmFM?=
 =?utf-8?B?QjFFRVpERmdpc2Z0dmNBNGhzeWZuamVkQmYyVGZsci9FNGtiWXc1ekJxcGtm?=
 =?utf-8?B?QlErdWJlSlhzNVBxRFFjRVZrRFdQWDgyYTBkQU44dW1OSDZ2c09aUT09?=
X-Exchange-RoutingPolicyChecked:
	lDVOT2CsAkiTVE3zpvgsDlk6OTMNx5sMyAjOdM2jAaQHWGyIfNWE8OdfixMfRAMUyqGFzoV2j52PQKMYeu+7j1Ncvlm7I8bn1wBwZXFR+aeRY5nRNiqAKLQvrXwtAvfKQZeiEQCu66AiOy40hqbriwj5OttL0eJvsrG41zZrzaPO3zmYB4S1tdqAuFByC7rLQhOvYMo+UV6bhOB00tp/kXJsFK/+ihmKk3eLfDzy+uKE5jqR/SnE3jw3LmYmComaRCNiVBgSH2XNBO5pi4EiBAMGjf1EkyP5BOiUe8gd5NHUTpRimTvGZemht52SJnjGQ4n9Ktkz1i/2hn/gQBwuWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e4gMmar+hiaCq1zca4c6QVnnWn9zQS35TG/pZusQdiGRjNQ1r+HXfx89jsk24KoE4w1OnAU/uqxO97rqn7zhK0YZEfKp8jqucQT/VKfIg47RkxEdPY8Y+kA+g+0IS3Zx3nsCkAlMm8DYOd44PlzBaVcwVeDwm/uK6Zknfk0hivXCpF3SqdXL9UGYC1C7zVpdo9t/i61Rt/9eI2OBcZxJQoPSVl8v8iMmVg08f5tR7TOKhiQxnBAXyKq2ZFX3eOMRhSK/5QcJ2I/MSHoiGR+Tztb0QhWrnAAOnFeqHlNSdJLLEacewJ4fe5DsMLc+C+cCada3/j0w0JHyow9AMCCcfsqsmxyJSaDsYNI/6wtrB1UDTGojmibAFZrXfJwaa2jWOSBBlZ/GQVFfaKjJcjhhgRD5ktQoj+JSDw1klNHylLlKcMw0SbAOemCaOOUjkDwEvLpzNhl4UHuGSUWlDJ+Hq+4vJ7E/YHnGFe+iZBrG2U3KWMnsSLsPXxK3WyMlQboJFctoEUJDq1FFpBNG65HtDAGvHmu3jxrFdA47rNNR261blMU2g5IrewC8Xc8x3lH733z5zZWmHwhtXRCyab+HwDYtI6sdAQ+rZfV8rjSqoNS+wDki4WC+RgwvUGSisgZM4D1a3423d3BA+UrEmvCRPw==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c8ccd4-cc2d-4187-a858-08def965cc52
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB11481.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:07:55.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB4639
X-Authority-Analysis: v=2.4 cv=C7XZDwP+ c=1 sm=1 tr=0 ts=6a7e07ff cx=c_pps
 a=ubi/tEtUf7BgGEus7N5h6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=Ul2ihcTNv6sA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zvN32FZK4hqnROEWhWPN:22 a=97G6QYFp7rf_mNjIeFqL:22
 a=VwQbUJbxAAAA:8 a=0QafeX8dEaX0NvCQ6LkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wVyqVtZzYlUaqjj5yePlOyhxSY6fOK3h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMSBTYWx0ZWRfX7vl7/Mtrmura
 vXFWFguURQzNcHtxx9uM0Icv5g3ssw9fyrO8t4lsSA76Xdxx5HouWq1RrbVybtT3woIucTBTb8D
 EobJ33L4iGUONnZeDjL1Yc1xoUpWo9BRdi7Nh+ZCZwEpbGU2123I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMSBTYWx0ZWRfX4zg2cVvuQkuI
 dYhP5/pfYMdMNkQeCbWBA7yshT9YaPU/99AdVEX0LtTFsavfA1BnDf9RhpFnl1vfw9lD+Mk/YDr
 eykh8JTf7JpegRTc3LEF2DAXH+3HFSW9urOmW5VFy+QmaGDSQMTtrIHfzxZ8DRkDRegdTlB1QSR
 nxjOq048pUUvKk6Jik7HV3aUG8WYOXs17ud827oh2tHJrr73a8ZXQRSonPIFdE0NZjtC61xFVrt
 3HDfNQAOFslAvSbg7CkTYnnffM7NyJIQHM3RXMfxUZ3GWeXOFqYsfmJ8TsaH74xq9g/xeqbliio
 mNSzHv4u/NMEKoFjeGGgzh3s6PexrbOMkw3y6YhwMC3S3WRq0/md9AUpJYNOdPJ/gauRYEUed3a
 uNHkrIMAeb64G2zyradvonWGKP8d3pUW2snQTiXaqSZ3F2KaJcZtha+APkI5ssHFbhGKuYvqbPI
 f2XNVGkeqWwuutnrcxQ==
X-Proofpoint-GUID: wVyqVtZzYlUaqjj5yePlOyhxSY6fOK3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608130131

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v8:
 - Remove unused variable in craye1k_get_attention_status().

Changes in v7:
 - Update sysfs-bus-pci text from feedback.
 - Add DMI dependency to Kconfig.
 - Refactor pciehp_core.c to remove CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
   code blocks.
 - Move errno.h #include into correct alphabetical order.
 - Add comment describing the reasoning for the debugfs counters.
 - Move craye1k_init() call from pcie_hp_init() to init_slot().
 - Make craye1k mutex global rather than in craye1k->lock.  This enables
   handling of craye1k_[get|set]_attention_status() calls before the craye1k
   driver is initialized.
 - Do driver cleanup on craye1k_smi_gone().

Changes in v6:
 - Change some dev_info_ratelimited() calls to dev_info().
 - Don't call craye1k_init() if pcie_port_service_register() fails.
 - Fix stray indent in #define CRAYE1K_POST_CMD_WAIT_MS

Changes in v5:
 - Removed unnecessary ipmi_smi.h #include.
 - Added WARN_ON() to craye1k_do_message() to sanity check that craye1k->lock
   is held.
 - Added additional comments for when craye1k->lock should be held.

Changes in v4:
 - Fix typo in Kconfig: "is it" ->  "it is"
 - Rename some #defines to CRAYE1K_SUBCMD_*
 - Use IS_ERR() check in craye1k_debugfs_init()
 - Return -EIO instead of -EINVAL when LED value check fails

Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |  20 +
 drivers/pci/hotplug/pciehp_core.c       |  20 +-
 drivers/pci/hotplug/pciehp_craye1k.c    | 687 ++++++++++++++++++++++++
 7 files changed, 765 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 92debe879ffb..8536d2ff30d1 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink
+
+		Using the Cray ClusterStor E1000 extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ac254f4ec41..861576d60a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6543,6 +6543,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 3207860b52e4..3cb84e5e13e9 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on DMI && HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver it is not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..3a8173f3e159 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -199,6 +199,17 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_init(void);
+bool is_craye1k_board(void);
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+#else
+#define craye1k_init() (0)
+#define craye1k_get_attention_status NULL
+#define craye1k_set_attention_status NULL
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
@@ -209,4 +220,13 @@ static inline struct controller *to_ctrl(struct hotplug_slot *hotplug_slot)
 	return container_of(hotplug_slot, struct controller, hotplug_slot);
 }
 
+static inline bool is_craye1k_slot(struct controller *ctrl)
+{
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+#else
+	return false;
+#endif
+}
+
 #endif				/* _PCIEHP_H */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f59baa912970..3e8e2b3069bf 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -72,6 +72,22 @@ static int init_slot(struct controller *ctrl)
 	} else if (ctrl->pcie->port->hotplug_user_indicators) {
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
+	} else if (is_craye1k_slot(ctrl)) {
+		/*
+		 * The Cray E1000 driver controls slots 1-24.  Initialize the
+		 * Cray E1000 driver when slot 1 is seen.
+		 */
+		if (PSN(ctrl) == 1) {
+			retval = craye1k_init();
+			if (retval) {
+				ctrl_err(ctrl,
+					 "Error loading Cray E1000 extensions");
+				kfree(ops);
+				return retval;
+			}
+		}
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
 	}
 
 	/* register this slot with the hotplug pci core */
@@ -376,8 +392,10 @@ int __init pcie_hp_init(void)
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
 	pr_debug("pcie_port_service_register = %d\n", retval);
-	if (retval)
+	if (retval) {
 		pr_debug("Failure to register service\n");
+		return retval;
+	}
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..9c5bee81fdf8
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,687 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/errno.h>
+#include <linux/ipmi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_SUBCMD_GET_LED		0x0
+#define CRAYE1K_SUBCMD_SET_LED		0x1
+#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+static DEFINE_MUTEX(craye1k_lock);
+
+/*
+ * The E1000 command timeout and retry values were found though experimentation
+ * by looking at the error counters.  Keep the counters around to troubleshoot
+ * any issues with our current timeout/retry values.
+ */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (IS_ERR(parent))
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	/* Return parent dir dentry */
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev,
+					     "rx msgid %ld != %ld",
+					     msg->msgid, craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err(dev, "Unable to register IPMI user, iface %d\n",
+			craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	mutex_lock(&craye1k_lock);
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k_global = craye1k;
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	mutex_unlock(&craye1k_lock);
+	if (!craye1k->parent)
+		dev_warn(dev, "Cannot create debugfs");
+
+	dev_info(dev, "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+
+	mutex_lock(&craye1k_lock);
+	if (craye1k_global) {
+		debugfs_remove_recursive(craye1k_global->parent);
+		kfree(craye1k_global);
+		craye1k_global = NULL;
+	}
+	mutex_unlock(&craye1k_lock);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k_lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "ipmi_validate_addr() = %d\n",
+				    rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k_lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	WARN_ON(!mutex_is_locked(&craye1k_lock));
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, -1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return -1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return -1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+/*
+ * __craye1k_get_attention_status() - Get LED value
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, -EIO on failure.
+ */
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+
+	if (mutex_lock_interruptible(&craye1k_lock) != 0)
+		return -EINTR;
+
+	if (!craye1k_global) {
+		/* Driver isn't initialized yet */
+		mutex_unlock(&craye1k_lock);
+		return -EOPNOTSUPP;
+	}
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k_lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	if (mutex_lock_interruptible(&craye1k_lock) != 0)
+		return -EINTR;
+
+	if (!craye1k_global) {
+		/* Driver isn't initialized yet */
+		mutex_unlock(&craye1k_lock);
+		return -EOPNOTSUPP;
+	}
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k_lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+int craye1k_init(void)
+{
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.7



