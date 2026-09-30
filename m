Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E8389104;
	Wed, 30 Sep 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786521; cv=fail; b=OQKbDWa2aneV0yyVGQlrkgRHsa7wUb5w6r+/90UYmWHNASPO/HweaTcZ2MjiTPLYKR+uWHoAS7iurw0G7HiJzWf/tTAKHaD3mLAWMZH9AD7mw2/CTquyjrMU7T+PeFdkXJp35lPp0isAHnLzfhiS2t9E/n8wetW5WxlZjLo8h0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786521; c=relaxed/simple;
	bh=uxDN2KYFzaxEDlP/7+f/VO8pnmL+tpKU8ybVaWUNJeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6tWk2isoDb/ok2Ac5UuWqdmIcobzx5N3Khp04i9wLCbeoogko0zxUg4t1I5IsdFhzp+mS42U9YpWuFczu4vmxnPLbU2U8/NikYm06eT1/OrBAiuVoVbWYKUO0BdGv+Nri+OYw+mDtdxSII1bT1E3q6LV1b5bRB7IGG7rxrgprw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7yOc5MX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ECrO9X6D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7yOc5MX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ECrO9X6D"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEqC63803994;
	Wed, 30 Sep 2026 16:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uxDN2KYFzaxEDlP/7+f/VO8pnmL+tpKU8ybVaWUNJeg=; b=
	Q7yOc5MXOuimSNO9Lm7R/q2Nzwg667sBQd/59067TrNAzMeNEPgRyU3fvd94BzNh
	VLdTWubgtZKXILerM0etPLHHk7XaC3E1160nFEUHDdvD5WIQ2504TIoQGZUYeK+/
	Uuo/cGopA/dwUu5/umTT1JWrzwsMncKNdZg0ydF1nw/9QS3znN1Q5XP9qiRenZo4
	Ej+5bOvor3pYoawMFRLN94OH300JkFJdq5GrvZQZ60oDo5LEEWqmEsRBXFfQZRcV
	dKehbsjU9A+khx9mTmnejuP02iJNvNj6JmSR5zEwEejIBNr2XRxiRZd7voPf+4XS
	4VSZnRPTlhrq0i//T5oSwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4myf50h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 16:41:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68UGZ8lt020522;
	Wed, 30 Sep 2026 16:41:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdgenu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Sep 2026 16:41:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIVzvSOU7JzhpsnPD97R5xbMUoDTBV8DJ04/MvKKDcpNUg0GEhUz+LbdTshj4tH+1n7os4KsCK90ue7oIACVs3PUdAxGgCwU2KR0UlPwqVi+10zg0CWVCeVAw8Nq6Ec4ARX4zgnCr8H2YVhifSAzM5tqz4Xp66JRf8ez/+kYjcba4NuZBUQfkytapL0nGlxXiMoN0OTwShG3Vx9J151r/S7HnRKj6dpEQYFlwJBLT6S+zKFZNONyOl15xOmnDv/lIKVrjje2vQMtHCYSfozjWg2fyZ+/atdxcrAr9hazL2rQ9owRpnbrAmJ+OL2Fll0vwOuy+1gpxLBzyfRkgUbngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxDN2KYFzaxEDlP/7+f/VO8pnmL+tpKU8ybVaWUNJeg=;
 b=yMKM9spSTWmZrX1qcnSMhP5zy+xLrXfB3poGC98cRKjr0fKAqWyc3+0BasRLN/RT2sx5hhLQtnXG/xzErKRMofs1ZswjsZYyxdKLC8c4AXN99bs/XiiIj/oOb/nCBMfSX4jW+ljdxfDR+HpIMWuQs8fKAnIttSmzhQnc7CP6Wz2vwbxOEU8dpcVhovDjJZqHgsFYrtJ75yKiLnSRZ4eNRQtrk/8V9iePu9jR1iC13VL3Ou7H+uMtE0GxUhMcnATOi339lVcJm5VxcwIlAzch54AC1DFBxi3/vv0k65h/MGbw/VrgcVps90/7pqn2gPwp725fAuDCJnMEy8EGhza5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxDN2KYFzaxEDlP/7+f/VO8pnmL+tpKU8ybVaWUNJeg=;
 b=ECrO9X6DpGsV4FnsIyIuQPzlyYexnYTn1WFcaysDQzHJIfweTJsuU54TCAhTh31+X/FIGhq0DDBbITpjSghi+8TLnRxM/8cmHuv5EfBC8qNVwuKT+kmbwxjAncB90yx1MfxdaRuf6sSJ0OEDovIo+pOzFTEMz24epsxS8VZEjd4=
Received: from PH7PR10MB6676.namprd10.prod.outlook.com (2603:10b6:510:20e::5)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 16:41:36 +0000
Received: from PH7PR10MB6676.namprd10.prod.outlook.com
 ([fe80::44db:ead0:2fff:9a8d]) by PH7PR10MB6676.namprd10.prod.outlook.com
 ([fe80::44db:ead0:2fff:9a8d%4]) with mapi id 15.21.0496.008; Wed, 30 Sep 2026
 16:41:36 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Stefan Roese <stefan.roese@mailbox.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Manivannan
 Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya
 Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] PCI: Write RCB only when it changes
Thread-Topic: [PATCH 1/2] PCI: Write RCB only when it changes
Thread-Index: AQHdUOqQNZtjHbEhiUC15WLqJd+yQbbnUzwA
Date: Wed, 30 Sep 2026 16:41:36 +0000
Message-ID: <9FA3B138-A24C-4F07-BAB7-7FFB2315CDC5@oracle.com>
References: <20260930144650.3701516-1-stefan.roese@mailbox.org>
 <20260930144650.3701516-2-stefan.roese@mailbox.org>
In-Reply-To: <20260930144650.3701516-2-stefan.roese@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.700.51.1.3)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB6676:EE_|DS7PR10MB4848:EE_
x-ms-office365-filtering-correlation-id: c2f3e673-7ba8-4dd3-0170-08df1f11b1be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|5023799004|4143699003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 hf6aq7KQ0OUmZyMjkfTZKuwzMcf3a3tat6DmCZdB1PTHSGo0Z03rL5T6GuZsV0A7uadPPYWtRxbZv9xWlgXllSgMCVJxGrBHwXjOLV0a6LrF8oTlRoeH12d3zoE8nr6yEngx8ri8U96Ax0LqF9uOfSOqushR+R/5uWSNDwK9LkSWbAB0SveqhEE+n21OQyLWwIoHhzHXZjtVj3XyMBW7cuhno+3pcZlfd3QMaym9OSxz5kOzj239GYp0W6ZGLFPzDYdwbb1ezTZU3ZIpvSQI1zVhKT83F9wslYcqv4efnqb9sr56hxuX+dST0Qq9MtGcp0p8u5I/lQt9WmbZPKRdxlSUuxw0RcIXURm7HP5RsVyvxCur2Ngn9SRU/Aw5S5mOVcq+nvNZOELqJpWy29QySEwPbX2E+ilrHZQXtVzKAkk1WMV92gTO6r5gbwjxk/ibunLtFIbS3Vai6U2R5ZcR3ewPhpFIreKC44Mmdbs+gdNdgeYOqbadKej/vyQkoVhgPXGCt760DopDmUH2ETXlaMJ63XGNyGfA81xYni+TolIJ3HqoNACrzESMczOM6WLdUSDYVjfgFk4DPm3AnAdaLGlo4s00tiJ4WoYTjQmD/uuyfZGySpEVnpxUznGfVpkW5jBc7nmMD/uzFe02xepcrAAdnh94hNBPZerUHvZnoeC2MBu6O9utinPITrQJcRWa76dqvY8Uo35jvQchoSoxpXsKjOD7/W2qbO3LIWO90vs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6676.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(5023799004)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXNaU2JlYi93OGhJVzZFLzlVc20zOWlZdGpDaEE4MFhDdG43VnlLQW9Hd0Q1?=
 =?utf-8?B?eGR1VERvcVdYQzBzVDE3am82RExxUXpLS3dEZms1REhtZE1NdS9Qb0tFaEpB?=
 =?utf-8?B?MWg2VkhDa01KMmtWaDVTRUFZaC9JN2VoZTlYclJram5GYnM4YmlzZEZ5b3FP?=
 =?utf-8?B?L3g5NFVIYUk2MXN6ZUZjSzlrcjFsRGJPTTZVUTZzYTBTRGt1TVlnYUl0UlJs?=
 =?utf-8?B?bnZNMktvVUMxOERhbHJScVNRSUtPN2k3RTdPdnZhWHpldGZCbkhKcmx2NEE5?=
 =?utf-8?B?Vk83ZTVrZGpRSFdQNzF1a1RFRkFMd2RXU1BwT3VXODEvUkFrazBHcVA1dk9W?=
 =?utf-8?B?b09nY3RHbXQvL0w1ak8xUkwzNkFuRVNpd2p5YlMzRW4zbXEzQStiYmhtTU5F?=
 =?utf-8?B?QUwvNnRXSVhrNS9sbzF1NzREaEx3YVRIRGJpUG4xM1VIdEExcWgxc2d5WWYw?=
 =?utf-8?B?eFpjVHk0L3dLTGZPZkE2aEN6bWdwTmIvNlU3UkNTSXFWYVRQNTNiU1d3aGlx?=
 =?utf-8?B?ZHpRcjdEeUVmVGZvTFJtTmF2SlNrZFNSc1NXWUhMSnBUc1liM3pWNkFId1NK?=
 =?utf-8?B?NG9Ba3kvWk9TMThwd3VqYm1QVkZxZE11bkNoOXRhWWpPd0l3aFRNdzV6eXJm?=
 =?utf-8?B?MVlRSjdBYWgwZVQ5RmtWTGlyTWNQWTRyM2RjYVlxWVZSbjBqNTREQWk1OUht?=
 =?utf-8?B?TWtwcEt3ejFFeDRSR0NaaExvbjQ3N0pTM2VZV2V4MkJIM2syMC95MjhPeFNF?=
 =?utf-8?B?aGlERi8rM1RFdEh3UVFyYURnZW9LM2UrN3FZNFhLOEZMUHBiWDYvTzU1S1lq?=
 =?utf-8?B?NXVmTTNaaXlibnhtMnhaVW50a2RGOTBSenN5RnpzMWxTcWVicVlIYktEQjhB?=
 =?utf-8?B?OEd3Q0cyVHNYdFRGdUs0cXRWYjc1dGEzWVhKN29WR1dIdWFTRlZ6V29BU3FH?=
 =?utf-8?B?THdaNFppbUdLUEtXS1VyR2ZsdmthdzRFZnZrS2crdFdSWWRzaXJjQTFtbjM4?=
 =?utf-8?B?eUgrRHUzYTREalFlRUtHNVQ2Ry91ZWVkQVVVVHFZeG9hUzR6U1IyeHJhM1RU?=
 =?utf-8?B?UldBTVVhRzZoRitRUzdlemMrdDROMmNJdk82L0xVYmNXQmJPQzlEMEY2eVNa?=
 =?utf-8?B?d3dHVFdRdmJBZEQ2SXFvSmpXNlNLYXlRVU9SaWgxNjZ5Nk5wdWVPeldaQ1Mr?=
 =?utf-8?B?U21yVWFaR1FXdDNqbTFnKzlNRVR2WWtNVGJMaEZ5M2xRUjkwVjhwRkdWUytm?=
 =?utf-8?B?UXgrVjB0bllxYTNvaXh3azZvakxDR0FxemlLaVlJakg1UmR4bGs3a3J0anRQ?=
 =?utf-8?B?dzZqZStqTUxENWM1L1NKRXNFbjc0aitNandwVDJxS0ZsaGN4UlI3NGdGZkp2?=
 =?utf-8?B?Q2xSRG5yOFZxcE5VZThTU2IwNVp3cnpnblJsWC9icVNVcFFRTGxtUEV1RVNq?=
 =?utf-8?B?ODhFZi82RXdrZFBkeHVSekhnZ2ovZDVYWjdKYkpKenFYczBWWHRHVXUzeE9n?=
 =?utf-8?B?UE9VSnRsSFA2VEJnRUJyVmVIRXpoZzlqcWV3TXUxWFBNd0JxUTd0d3k0QzNE?=
 =?utf-8?B?WWxtSmFkRHlQU1hZenc4ZENSWGFKMms5TFZhSVpaY3QrajJnWUlSME9HejB0?=
 =?utf-8?B?YVZyeTZBOXU0Z1VKNDg4S2JjRzVuQXM2ZllTSnVoOW9zRFBNVHVYWWxpNnly?=
 =?utf-8?B?WEdaa1lVa3JOWjRDSks5UStSajNqbnR3MG9XOTFhdXo4cFVGY0dPUTlsSWZ0?=
 =?utf-8?B?cmJ4dlluUEVjeVQxRzN2OWk3elo2Zk40QUxwUzMzS01QUmR6bmJlYjg4VXU1?=
 =?utf-8?B?TGh4aTdwTVB5K05FK2FvRm1iUlV0RDI2MUo1b3Z1YVhpOUdRREdOcG5JSjYr?=
 =?utf-8?B?Y1BOVDJGVE9ZdS91aE5hUWxpYzViUy9mQ0phbm9zNXZodFpmZ0Yxc2NoWkVv?=
 =?utf-8?B?STkwZDNmME5lSExuRDk1TkVXUStEbk94d09FcG1yTHRLQlBmdzVOUTRRMkRo?=
 =?utf-8?B?YmJwZGpNU0d5aDd1NWtwL0NueTgzVlhXK0x3azUyVmNHMHNUaWdUaVQvUG1G?=
 =?utf-8?B?eXduV0hUbnZGWVFoYnRNcHFjd2RJbnIvNENjd2RnQlNIVW5nRUY4V2pnNlpE?=
 =?utf-8?B?MWpUMms3eit0dDRrL05YWVRRYUQzUWhyaUxMa0krZmR3b1lQQnJxaFIvaWRY?=
 =?utf-8?B?NWthekxvR2Z1eGcvVjBPbHJDY1NiOUlwVHpQcVZJc21PRWNYOFFFeVhjUDNp?=
 =?utf-8?B?RlRMZTJiUVNBdkx6dEVNUzhRbElHRnpUanFqc3Fpb2xJRzNGTU9iQ0J0SytO?=
 =?utf-8?B?NStrdDR6TlJWbG9hU29zVWJKeWplWG5zRzE0L3prZXBNWWNheG15azZLc1Mz?=
 =?utf-8?Q?rYIpvED7WfuBV8jw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB1E2A8D0885348B9FBCBE382DF6DB5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oGes45r3qCK4wbp703VBffm4AXkIK+TxvWLXLme5Yrs/isLqTkTFtUPlt+d3p3EKfen/UKQYrBS0hjeZpzfX/1VlwGVRG+GS0hDf9tn/kHDlDiv8Ze6TayO2sVwPYq3s4nycgvDpcQfva3RoC5AB3Nba/eOzXOm3BwI9hf9hqqihMHApKDx4LHRT1j3AC9tz1fvAjOxFjNd8puI//je+tcB/WeGSKyhTz4kk0Dvj0famCCYE1zlSDuNSHDAt+5QnawA0xaf5DQdzgH6vdW4MIp2yYGOWaJtt8ospbTmrnZ57AmUBUwwhYq4Jttb5VhAOlT5PjsK8A7Q0Ke+lzAaQ5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOIw+tk8Mjk+hGmYB6Cn904Zbr4EvUpiXYHiCraZEpE5n9rdnuw01OsJTC6tHy5NqQp1KCbj00UdN5/eAAC1bqJ/WU0l7vghBUjd47XezYtXIJriczjGbntJC8kAMUNN+eGE/KPaFfCQrm+F3+DVuKBMuUvhgx1gevhYt3b0AyhV/UtggjocMkYD/HR90yb6YDUNOO04pNJnlJE9tPYBzmEDQEkNCTh2PaB7RaESoW9tkpba/zgmCDimP2GJZtO3uHGaflEnrx/BWev2OQsYIMjeHOos9EN+jixkS/0x4QmrDj8oTu1GeRJLG8tQUtAajbhRfazyXZbyW3srrVlBI6UacxHh51RtFFuxekRL0QZ1Yd4K29WIP5FrKEl5UrbCwzuVu6vrvygSIQu1151U90xIFVW+jOLZ1oMwR/dHe4TPecQoIfimsA9y069AarsH1MrldfKF076Gr5c/aLlBDSr3bbSebf6NFHPvXVjbv0hG1/bkR+892+B0NCgS2nNgwWSzbddPtMcV2O7QgDpweS19oWpLnWXN2kGUiWk3+WexD/OVxBl9jR4zt0YRh+1j2obRSjs+iInfwYqdqzTlXoN/YBrmHynlezNf2c8D/NE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6676.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3e673-7ba8-4dd3-0170-08df1f11b1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 16:41:36.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlJeyrW7ackRdAPR7yROpruRbtZdkHrx50jRzh885POkch24B0OHno5VxuXzGn1zGd0OSlgJ8bgAu29fxZfB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609300066
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfXwGms9mHMz+vI
 vwmJMaYthK2fP78WWb3Bhq7Xq9f75kbAqjMmSdiqV+ddTzvTzh1zAOGcrsT+LXvxjMaDt4vK7x0
 P9f2j5LXwuONh2JelnuSuPVm5UQLHHIxhNxcaZRyhZ/RvXXoFKtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX+Yi2ZzA8idZv
 IYpk9i1vYgHsQLrGkzIVjEinkmk/xnr++jcVx/ozpHYD9lYwzbCB3VnzmsKzfpbNQk1xBbu9K3Q
 HWHMLLPsba9w48FPPzmW7KRtaAALGbrcx9yM+fxrYUjA+zR3jmdr9iAh7SpoAe25vyLqMKOGwro
 SJlun81cdXPWlzBrupjd7M9DEWbpNPnbrJoOZ/PGkLyCTE/iK6QgBT7vpwMp7KrBNvQmiMn/5J1
 bZrguINiyQQnmk/mbBTc+c5NYfXtKZwWh+9VbWQzQxi58g7YrDszXCAhimA2zLVYJ0VPfyntsDz
 t/s3b8zsveirY0DIHDZlUWSXEzaEkBI1WHOB2KEYqZ5rm7wsC1gijh99ihgcYzj0Fh8FNhX1ncw
 AnKbYlyDjuy+tmsJUycsAWyoe6BR0ayd+EwDdpU/A2OyQg4DgiSH1bbshhN3M/PPAdQP0MXWQf/
 SmHZ4mciMHo9dpy9NsA==
X-Proofpoint-GUID: g7-oznNivNSQ9cyFiDkG4frOJtlikFBG
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abd3bc7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=b3CbU_ItAAAA:8 a=cDgzUWrCpirYoJPFFZ4A:9
 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: g7-oznNivNSQ9cyFiDkG4frOJtlikFBG

DQoNCj4gT24gMzAgU2VwIDIwMjYsIGF0IDE2OjQ2LCBTdGVmYW4gUm9lc2UgPHN0ZWZhbi5yb2Vz
ZUBtYWlsYm94Lm9yZz4gd3JvdGU6DQo+IA0KPiBwY2lfY29uZmlndXJlX3JjYigpIGRvZXMgYSBy
ZWFkLW1vZGlmeS13cml0ZSBvZiB0aGUgTGluayBDb250cm9sDQo+IHJlZ2lzdGVyIG9mIGV2ZXJ5
IGVuZHBvaW50IGF0IGVudW1lcmF0aW9uLCBldmVuIHdoZW4gUkNCIGFscmVhZHkgaGFzDQo+IHRo
ZSByaWdodCB2YWx1ZS4gU29tZSBkZXZpY2VzIHJlYWN0IHRvIGFueSB3cml0ZSBvZiB0aGlzIHJl
Z2lzdGVyLg0KPiANCj4gVGhlIFJlbmVzYXMgdVBENzIwMjAxIHhIQ0kgKDE5MTI6MDAxNCkgY29t
ZXMgb3V0IG9mIHJlc2V0IHdpdGggQVNQTSBMMHMNCj4gYW5kIEwxIGVuYWJsZWQgaW4gTGluayBD
b250cm9sLiBPbiBhIGxpbmsgd2hvc2UgUm9vdCBQb3J0IHN1cHBvcnRzIG5vDQo+IEFTUE0sIG5v
dGhpbmcgZWxzZSB3cml0ZXMgdGhhdCByZWdpc3RlciBiZWZvcmUgdGhlIGRyaXZlciBsb2Fkcywg
YW5kDQo+IHRoZSBjaGlwIGNsZWFycyBBU1BNIENvbnRyb2wgaXRzZWxmIGR1cmluZyB0aGUgZmly
bXdhcmUgZG93bmxvYWQuIEFmdGVyDQo+IGEgaG9zdCB3cml0ZSwgZXZlbiBvZiB0aGUgdW5jaGFu
Z2VkIHZhbHVlIDB4MDAwMywgaXQgbm8gbG9uZ2VyIGRvZXMNCj4gc28uIEFTUE0gc3RheXMgZW5h
YmxlZCwgYW5kIHRoZSBmaXJzdCBhY2Nlc3MgdG8gdGhlIHhIQ0kgQkFSIHJ1bnMgaW50bw0KPiBQ
Q0llIGNvbXBsZXRpb24gdGltZW91dHMgdGhhdCBoYW5nIHRoZSBzeXN0ZW0uDQo+IA0KPiBTZWVu
IG9uIGFuIEFNRCBWZXJzYWwgYm9hcmQgKENQTSBSb290IFBvcnQgd2l0aG91dCBBU1BNIHN1cHBv
cnQpOiB0aGUNCj4gaGFuZyBiaXNlY3RzIHRvIHRoaXMgY29tbWl0LCByZXZlcnRpbmcgaXQgZml4
ZXMgaXQsIGFuZCBvbiBhIGtlcm5lbA0KPiB3aXRob3V0IGl0IGEgc2luZ2xlIHNldHBjaSB3cml0
ZSBvZiB0aGUgdW5jaGFuZ2VkIHZhbHVlIHJlcHJvZHVjZXMgaXQuDQo+IA0KPiBSZWFkIExpbmsg
Q29udHJvbCBmaXJzdCBhbmQgd3JpdGUgaXQgb25seSB3aGVuIFJDQiBoYXMgdG8gY2hhbmdlLg0K
DQpUaGlzIHdhcyBkZWJhdGVkIGR1cmluZyB0aGUgcmV2aWV3IG9mIDFhNjg0NWFhYTZkZS4gVGhl
IGNvbmRpdGlvbmFsDQpsb2dpYyB0byBhdm9pZCBhIExpbmsgQ29udHJvbCB3cml0ZSB3aGVuIFJD
QiBhbHJlYWR5IG1hdGNoZWQgd2FzDQpjb25zaWRlcmVkIOKAnG92ZXItZW5naW5lZXJlZOKAnToN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjAxMjIxMzA5NTcuNjg3NTctMi1oYWFr
b24uYnVnZ2VAb3JhY2xlLmNvbS8NCg0KU2luY2UgYW4gdW5jb25kaXRpb25hbCB3cml0ZSB0byBM
aW5rIENvbnRyb2wgd2hpbGUgcHJvZ3JhbW1pbmcgUkNCDQpkb2VzIG5vdCB2aW9sYXRlIHRoZSBQ
Q0llIHNwZWNpZmljYXRpb24sIHRoaXMgYXBwZWFycyB0byBiZQ0KZGV2aWNlLXNwZWNpZmljIGJl
aGF2aW9yIGFuZCBzaG91bGQgYmUgaGFuZGxlZCB3aXRoIGEgZGV2aWNlIHF1aXJrDQppbnN0ZWFk
Lg0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IA0KPiBGaXhlczogMWE2ODQ1YWFhNmRlICgiUENJOiBJ
bml0aWFsaXplIFJDQiBmcm9tIHBjaV9jb25maWd1cmVfZGV2aWNlKCkiKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUtNQ0K
PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUm9lc2UgPHN0ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz4N
Cj4gLS0tDQo+IGRyaXZlcnMvcGNpL3Byb2JlLmMgfCAxNyArKysrKysrKysrKystLS0tLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiBp
bmRleCA3MjFkYWY1YzUxODQuLjM1ZTc5NGRmM2JlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
Y2kvcHJvYmUuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+IEBAIC0yNDI2LDcgKzI0
MjYsNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3NlcnIoc3RydWN0IHBjaV9kZXYgKmRl
dikNCj4gc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9yY2Ioc3RydWN0IHBjaV9kZXYgKmRldikN
Cj4gew0KPiBzdHJ1Y3QgcGNpX2RldiAqcnA7DQo+IC0gdTE2IHJwX2xua2N0bDsNCj4gKyB1MTYg
cnBfbG5rY3RsLCBsbmtjdGwsIHJjYjsNCj4gDQo+IC8qDQo+ICogUGVyIFBDSWUgcjcuMCwgc2Vj
IDcuNS4zLjcsIFJDQiBpcyBvbmx5IG1lYW5pbmdmdWwgaW4gUm9vdCBQb3J0cw0KPiBAQCAtMjQ0
OCwxMCArMjQ0OCwxNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3JjYihzdHJ1Y3QgcGNp
X2RldiAqZGV2KQ0KPiByZXR1cm47DQo+IA0KPiBwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKHJw
LCBQQ0lfRVhQX0xOS0NUTCwgJnJwX2xua2N0bCk7DQo+IC0gcGNpZV9jYXBhYmlsaXR5X2NsZWFy
X2FuZF9zZXRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLA0KPiAtIFBDSV9FWFBfTE5LQ1RMX1JD
QiwNCj4gLSAocnBfbG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKSA/DQo+IC0gUENJX0VYUF9M
TktDVExfUkNCIDogMCk7DQo+ICsgcmNiID0gcnBfbG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNC
Ow0KPiArDQo+ICsgLyoNCj4gKyAqIFdyaXRlIExpbmsgQ29udHJvbCBvbmx5IHdoZW4gUkNCIGFj
dHVhbGx5IGNoYW5nZXMuIFNvbWUgZGV2aWNlcw0KPiArICogcmVhY3QgdG8gYW55IHdyaXRlIG9m
IHRoaXMgcmVnaXN0ZXIsIGV2ZW4gb25lIHdpdGggYW4gdW5jaGFuZ2VkDQo+ICsgKiB2YWx1ZS4N
Cj4gKyAqLw0KPiArIHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NU
TCwgJmxua2N0bCk7DQo+ICsgaWYgKChsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpICE9IHJj
YikNCj4gKyBwY2llX2NhcGFiaWxpdHlfY2xlYXJfYW5kX3NldF93b3JkKGRldiwgUENJX0VYUF9M
TktDVEwsDQo+ICsgUENJX0VYUF9MTktDVExfUkNCLCByY2IpOw0KPiB9DQo+IA0KPiBzdGF0aWMg
dm9pZCBwY2lfY29uZmlndXJlX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAtLSANCj4g
Mi41Ni4wDQo+IA0KPiANCj4gDQoNCg==
