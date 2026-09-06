Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C323A564;
	Sun,  6 Sep 2026 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719663; cv=fail; b=DJyj22tAlahNOFo8cjNarvuzBy8yrgSOyIrDlHqzGyd0HwnlxnYdCYS8A/BMe3q2ADklzqRZJdP5h0lM8PjSU5/4zKND290gyhNl7AcOEc6QJOEMIyeYnUZNE03Wms0+JmTOLSW/WDdWF8+j/a8FMYn3mjarSk3jtUH29Bu/rQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719663; c=relaxed/simple;
	bh=ghQxTpxa01n59yIfK56bllVr3AOZblerr1qVxs8FunA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DAt40ekyzMF+gHkr3y96aDmUnC8cmZAmiuk8/eyUq5tsfoeV3M62O/05Lbt8l2O0EKCbrYQw73pMBei+R+XYmw3sf8vvnzjG2uBksX2u+oYSqDkg5Wmu4AkXpuovRY7SuvlwGG8WyXYTHmfj4+PmZQtBlGUR2wcDpnSqsmLzfdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=f1kQdldc; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="f1kQdldc"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686HlRKa315313;
	Sun, 6 Sep 2026 14:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=ghQxTpxa01n59yIfK56bllV
	r3AOZblerr1qVxs8FunA=; b=f1kQdldcMOZ9b9f+jveiOkpq7R59YYTwAju0+AT
	7Ob6kEm2K13EZzOd/l80Tpmakxrp6Qv80XDAYL8wiv/JhveCMY50uDJnxxSNag1u
	yyn2aJEHCBfGNh2pjkLtBEbHgccY8Bzva9Y4Npdmtw1XEypRbuaU2oYINuxSFQFh
	m2fSQQlVkpOrdC8+Apr+pHoaL6f90pe39dQnlESTWLG8r1NsSTh1MVo0zg8AOUF4
	7JnDLKe25ZO0138RG803bklNQefw5eUNusadhAdzCXAeuv7jY/Y1J06hHah/1y3B
	hsUPfRAKi/ZDhKUfStdPnnNqSwkMFJepbRwNvHsry3/LR6w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gge8d2mcg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 14:34:10 -0400 (EDT)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686I2GGY1930916;
	Sun, 6 Sep 2026 14:34:09 -0400
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ghd2q06n9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 06 Sep 2026 14:34:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv2QVm/1vyo9QlryuHmgrxgiQGZB1IPl+aw4AkuK9x2rtXyeeLV+85lIzzv5HRORlxeMKMLNYjrtK9/2DkPLmKmyPLONyTV0bi1NNuuzsyObZurUvPAzAbWxaZ9Dw1WeZBloOy1WOt10p1NdCqHP7Ew1BmZF/0GjGWkvUnyrLKWiUEpkP+sf6IhqK9b4TAHsqKlX+oqRXHsGAM75A7Y8sx50z/CuQGdNo4rpQEg8QlCxSXR1gfIMx55c+Z64D8NJaUmme8Em3c3DY/Lhj69Um2roTLYwyiJbQUv/Z/ApoPjTeC2hHXhI4I/setLIa7kcbn2l0r4zKP62pR06DY2WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghQxTpxa01n59yIfK56bllVr3AOZblerr1qVxs8FunA=;
 b=mOwoY3FXGQ2hGHmJ6aknueJjqOik9akfpMGOEsVVGLFM+gHVB0Fi7NvgW7XddNEmIxwCcenGEnCYTPYl0I+nvWMwz304GA+SDZVjM5Z/sUdO4KWTE8DlKHidJZS4/PfFj/4FrojuWHYs42rf8N7rTp134ottNdITzqm6IPyPZQfjnDZzG54LiXWSwGSrTjcMVdfaGuvoL805iJxnnVI5Vbq5bTTI4rR+u8tBeDnw9W8vcdtdXSRQG4jqQ9VNdWCfbvSy43UMkg2DQzhhjE9ufjfhGqWy1VB1F1xn1XUW1q3nNJx8aCcFnSacObk6q+otYjIJ2rihg88obfBuDYADwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SA6PR19MB8551.namprd19.prod.outlook.com (2603:10b6:806:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 18:34:02 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 18:34:02 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Farhan Ali
	<alifm@linux.ibm.com>
Subject: [BUG/RFC] PCI/EDR/DPC: vfio-pci endpoint left disabled after
 successful recovery
Thread-Topic: [BUG/RFC] PCI/EDR/DPC: vfio-pci endpoint left disabled after
 successful recovery
Thread-Index: Ad0+Lb0YatSNqeO5RVeXHIGU0YIZCA==
Date: Sun, 6 Sep 2026 18:34:02 +0000
Message-ID:
 <CO1PR19MB48858DF4BB793A09ABEA7E1DEEB32@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=c5b9959e-5d64-41aa-8fa8-a505adb1825b;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2026-09-06T18:33:56Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SA6PR19MB8551:EE_
x-ms-office365-filtering-correlation-id: b13ef92e-f545-4d2b-7da9-08df0c456c7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|786006|23010399003|1800799024|38070700021|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|3023799007;
x-microsoft-antispam-message-info:
 /PJb/gYSEPf3LzO2ggzciu+ql3G1PLpyp1AeF7JoykBGU3nvl+10HSnHVJ0gNdsyk+AIZ6+bVePYcjdotqefWpcLfSeC22o09iVB2p4SMyRMUVwBhynJNXcGJYDOH8JuV+Sp6v19lP4CX8TuVTAHpQ2lxbP5exQITeAtR03qIokdLpCAmhV+L0+YXj/uRo3PqXBnjrHjah+aSNHW2aoa6etKyM85eLHIwXkUqq4ivZxbQ+8oe6BNjSP0hWs4HViZU8V3ScNlD/mUtE8V1XWE4cKYel6j64wuSlLbvyAXrwr6X7qxjiZTfW4K54HjOxA0bmuB2SPwQG6qCPgPcEdqh2mPqZ8njlz7VcENQhgaEadG67xGFhrGcxlKG5CW+kLqtECLybtxcJM0+2AzSwg6RUY8ZHlQSpm/KQhm6yHe7ONzSzlXGPXKUwcULhKqtBvcgWnRwjcywnqRz3Tk24iMrEDwJ++HeknzXq9m4i811iDwvmvnLa2Sk0/xnyYDt1jfPA9LhSbY9S6zAaLaMW1fH4eizWCseBKJ+Mgz/+ddvIBg1vgk4n3cJv1rjma/8dR7k3d9zMX88Gi5OHVjXNqrEnJMZqAltjOXEZbLMpqCXIrwZyGLWrOsRm1B1Q8Pi2ZUbh7+MO3QbUGvxSEalW10ci2KHAMlDkH8ivmtglF51gNbRRgfNgM6mXadCB8BdgO4YiM3Ni1P3lrog3YKCirN1V2RvG/VbgS0aerTGHMZOps=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(786006)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RtD3exsulQElI5qRKkU4yuXDPLfFwx2klvi+9Luo6zwvgNPfoF0nmjUZVhTJ?=
 =?us-ascii?Q?I383OZyhxKHXJWxlJKcz2ZnykPq5iz1B2/kyx8j10LzpAoexTk6i2sHrUKHS?=
 =?us-ascii?Q?4dCYEZZPDd6obww07TlCX9sXRrsJiHjNc2cAgNe90cSlFo//3W3QPpSTeMqZ?=
 =?us-ascii?Q?khEU1M+mNXg+Q8hUh7FnlhLwzWNnNhxBJtCQiod++vhSJDQfNu4p5BfrugUE?=
 =?us-ascii?Q?BlN/H/cfydXobZ4xXhCPVvyRaqPxeY6FmBsWh6xKu29CUDoWdsQhDIAb42XD?=
 =?us-ascii?Q?r2YM+LpX3uun6GxHQVa5CiFX83gTuoRVJQOYwTm3GmLVjOnHZ0/bjoYkCjzE?=
 =?us-ascii?Q?zH8shkEUniFyyR/Oaz/PbDiidMEwgqK+WxFAYdLmGFx+NugnEV0jY3bMyffN?=
 =?us-ascii?Q?1dqhgZElXlEmO03fPLwVev/quUer2EICJQGh+toa7DfYSopWufh+rO7xX0E7?=
 =?us-ascii?Q?V7B+tjTKyxVoERBl/pgIjbpTcKnE29n9aQBWwXy5ywDcmBuCHKTmq4bkJ/F2?=
 =?us-ascii?Q?osyCSt6fmBe5EGuBsdJjoVWhf4cT7rKouyxTTS17PGXfOvRmoK/q70R/k6f0?=
 =?us-ascii?Q?aTbm/DCPYeMJIlHPO7mXDUakop4YhLcGcAeuY+EeU48aHJQjvXpaeZBbYxpb?=
 =?us-ascii?Q?lho6Xbp1queZJuwcpnVAvN44p9JsfGfTr6KnvtTY4GUPLWNyYpc3+3/sHTzi?=
 =?us-ascii?Q?b8Crv3fLkEflgAgsH8ybknvDhxBk37Aq8HZXmdPtJKTHb5xSrdZnBt3W8HnO?=
 =?us-ascii?Q?2WY13UZjlDsGhsIkBtrZj9B54teWSKlDOEpn9mz/gzW9QJvobY+dyo7K46/A?=
 =?us-ascii?Q?/KvtNHwhVIOrjMhgezBSkVD9YLPV4UFrXVTtfpJSkq+AOAeBrzW9C13p35VH?=
 =?us-ascii?Q?xThLiTBgBXEi7iTRZLFM1bsZZO6Qd25yNqjlnEuW195qN/FO7n3S3kBU89P6?=
 =?us-ascii?Q?HsyRyVl5A3KCu2eUxfvdlYXZ4KE6pi+sy+41QpiUGiDRK6NHKNxeupZYNcKS?=
 =?us-ascii?Q?cp0+PYoI2urB+LRZ8GuJJQ4GEMCeKT9/fWYhQDd+NYNqjLjmLpGEHMWAWbzy?=
 =?us-ascii?Q?gNlupGxt1lX379Rab4ZzmpoCGcF8M230/3G93YqQ7rflNwumMeadsC/z7WsM?=
 =?us-ascii?Q?QHrYxN4Y5ohEHGeB0Q1w2iqtLT9+O4AOgM8dleMW+RMtPY44/3jSPuGXG3l9?=
 =?us-ascii?Q?xW13KGeUAsHXwhnlJL+fo9jCKX6dZB7a58rA2BumSnTqFTN2LPj2RuZE5smw?=
 =?us-ascii?Q?ywfAYHAsUnHYTzH4/wxvC4/Bu9OXn2MtCB57TY+7fTobtP25AycySyryhgVc?=
 =?us-ascii?Q?GdsUwu3ba0Mtt7FdGYDMuBKjr6s4n7jCp4GvLRc0Z8CjCkOH0XNOUoK20quL?=
 =?us-ascii?Q?znob2hZ7KCKfLuEJw8TBrfiv90qBI9nNb6GzpePQez2ol+Gp2HwaDc8cgA+8?=
 =?us-ascii?Q?HSeGQJBMikXpEQrWQ8F5aDwug0Adk45kGm3Ricb+VaG+UdxDe2NibokX2sib?=
 =?us-ascii?Q?PnyCQ2d7qxYLxlmt99RY84u4DGC/FjPyS5OAw8ZLMqmZ02JryflHY6Dk3Wpt?=
 =?us-ascii?Q?aGrVZLx1a3xqHFlQlwMHNcHcJm2ZylgB27mYLSf1ytWDOow0OTkeGnjkmGo9?=
 =?us-ascii?Q?b3jELdtbd4UeZnZ3/oHaN+KcjbHT3NjhsF5s8yw01UPgVBcUsHRvJwIWYUFf?=
 =?us-ascii?Q?6yGwLwsSVtyKI0ndBjXvWlhklAy6Y0QpF9vRidWLjo44Sqjg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	yI4WFQzfqZtPbOS+H9ijMNJlWfJeC63FDTS+y6ZOweEIYcTjwpAEDz2R9lCfiA7bc3KQkmMzfckCgfia3vTJIgnxfhcmJaKoSWXvfWj3fQodk6wUmymj3VOwWDD/8kr4PSngLhVUTRHfT9476Z6VLESRMZL85c4/62bEJ8B3ewNzI4+6DWlyYSdmgmIVBj28ztabFB7nY1kjaCJGFH3mWGRxKCoiklLHGYlUHKnKdTgIo2gKaGvCvfpIoxh5oPUPGNvEaP5OFSvWBni6PptzAnQC38LL5TR6hkrteOcylSzi49hRN/7ePAtvgAjaIE7oHPiRtnmmr0c/1PhpBDkReQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13ef92e-f545-4d2b-7da9-08df0c456c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 18:34:02.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnFBUbk0MF3OifedgaIK8H0C5XYmkItRVz+QWmJoubzgUxWOeCumaSA+drBt1f2TtLPzCVRjZ5djxlTnBYfiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDIwNSBTYWx0ZWRfXzEfIsLs4UIsq
 1W2zkj0cOGFQA3QNWpw/WUaLZPW2ZgnNTqhUDtAG3K3/UamRZ7qvh1isIuGynGDADC1l1dSFeZ5
 h7C6yy980gCwWgfot+xlJLZhRJ1Fn3Ema9sRe38FTZTuDBu/KNXL5CM8ceNPxN9zf66mOtK0YE2
 K6S0ZxcLdjcatILO0y2OvAU9e0v/4Qps0A0E2/R7D+wHRGgdFi7tY1gchJCBDa6nI5j5m8NnTXc
 2gt+FDqaoMk0ugezdonGpulREPmgTl9OiMVvvjvdYfOiU4biQHPjnLs1YseYVjxksPEq9bvZmkD
 XtWidKwn42Bwv3xKfkC3i76Q9w7US+5Il9dis2V2w4HOWmneoX2G4SHiz+MIwGIiiF/JM2opQFk
 ZuMBnvQQBSmKOcgU9mbR1Hig4cYfvpdR1rUoxew4990DBD4axEB3RLhJLTeKPcV2C32c8VaxST1
 F6hVrj7aH8oQ/HlC/bQ==
X-Proofpoint-ORIG-GUID: gBHnwfqh6J3z3qf9TYQNR6RXgqVN6nl2
X-Proofpoint-GUID: gBHnwfqh6J3z3qf9TYQNR6RXgqVN6nl2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDIwNSBTYWx0ZWRfXyZYaBeCNkrWq
 Nmx1+bl2UTI8fuHoHc+4xQgHwBZYb9twRx1KDELnC42XuShVgdLBGJdB45o1J9Nti/lztEcM/kF
 Uo7EI37bBLSOg7tp9+amHS/5lxw93pk=
X-Authority-Analysis: v=2.4 cv=KO5qylFo c=1 sm=1 tr=0 ts=6a9db222 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=m3zZTHMLHbwB7Lmtoed2:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DDIUGRlXtVaWbviejJ8A:9 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060205

Hello,

I am investigating a firmware-first PCIe DPC/EDR recovery issue involving a=
n NVMe endpoint bound to vfio-pci.
Linux reports that DPC recovery completed successfully and sends EDR _OST s=
tatus 0x80 to firmware.
However, the downstream endpoint's PCI configuration is not restored: PCI_C=
OMMAND remains 0x0000, Memory Space Enable is disabled, and the device cann=
ot accept MMIO accesses.
A manual Secondary Bus Reset later causes hot-remove/re-enumeration and res=
tores the endpoint.
Environment:
Platform: Dell PowerEdge, firmware-first DPC/EDR
Kernel: 6.4.0-150600.23.92-default, SUSE Linux Enterprise 15
Endpoint: 0000:07:00.0, KIOXIA NVMe
Endpoint driver: vfio-pci
DPC downstream port: 0000:04:04.0
EDR notification Root Port: 0000:00:01.1

Reproduction:
1. Start IO
2. Confirm the endpoint's initial PCI Command register:
setpci -s 0000:07:00.0 COMMAND
0406
3. Clear the Memory Space Enable bit:
setpci -s 0000:07:00.0 COMMAND=3D0000:0002
With IO active, a component attempts to access the disabled MMIO BAR. This =
results in an ERR_NONFATAL event and DPC containment.
Observed EDR/DPC recovery
The kernel reports:
pcieport 0000:00:01.1: EDR: EDR event received
pcieport 0000:00:01.1: EDR: Reported EDR dev: 0000:04:04.0
pcieport 0000:04:04.0: DPC: containment event, status:0x2003, ERR_NONFATAL =
received from 0000:07:00.0
pcieport 0000:04:04.0: pciehp: Slot(167): Link Down/Up ignored (recovered b=
y DPC)
pcieport 0000:04:04.0: AER: device recovery successful
pcieport 0000:04:04.0: EDR: DPC port successfully recovered
pcieport 0000:00:01.1: EDR: Status for 0000:04:04.0: 0x80

DPC Trigger Status was cleared,
Therefore, the link-level DPC recovery appears to have succeeded.
The endpoint remains present in PCI enumeration and sysfs and is still boun=
d to vfio-pci. However:
# setpci -s 0000:07:00.0 COMMAND
0000
lspci reports:
Control: I/O- Mem- BusMaster-
Region 0: Memory at ef000000 [disabled]
Kernel driver in use: vfio-pci
The endpoint cannot accept MMIO operations in this state.

Later, I manually issued an SBR on 0000:04:04.0. This caused pciehp removal=
 and re-enumeration:
pcieport 0000:04:04.0: pciehp: Slot(167): Link Down
vfio-pci 0000:07:00.0: Relaying device request to user
vfio-pci 0000:07:00.0: vfio_bar_restore: reset recovery - restoring BARs
...
pcieport 0000:04:04.0: pciehp: Slot(167): Link Up
pci 0000:07:00.0: BAR 0: assigned [mem 0xef000000-0xef00ffff 64bit]
vfio-pci 0000:07:00.0: enabling device

After re-enumeration, PCI_COMMAND and MMIO access were restored.

This seems related to:
[PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci driver
https://lore.kernel.org/all/20260603182415.2324-4-alifm@linux.ibm.com/
That patch restored VFIO's initial saved PCI state using:
pci_load_saved_state(pdev, vdev->pci_saved_state);
pci_restore_state(pdev);

This is conceptually similar to what appears to be missing in this reproduc=
tion.
However, reset_done() appears to be associated with PCI function-reset oper=
ations. The EDR/DPC path uses dpc_reset_link() through pcie_do_recovery(), =
so I do not believe the proposed reset_done callback would be invoked for t=
his case.
I also did not see the generic VFIO reset_done patch in the later v19/v20 V=
FIO series. Was it intentionally dropped?

Questions
1. Is it expected that DPC link recovery succeeded but no endpoint driver c=
allback confirmed that the PCI function was restored?
2. Should vfio-pci implement slot_reset(), or another post-DPC callback, th=
at reloads vdev->pci_saved_state after the link becomes accessible?
3. Alternatively, should the PCI recovery core restore generic PCI configur=
ation state for downstream devices before reporting recovery success?
4. If the endpoint's PCI state cannot be restored, should EDR return a fail=
ure status instead of sending _OST 0x80?

Before reporting successful recovery, I would expect the kernel/VFIO layer =
either to:
* restore a safe PCI handoff state, including BAR configuration and
Memory Space Enable; Bus Master Enable may remain disabled until userspace =
reinitializes DMA, or
* report that recovery failed.

Leaving the endpoint enumerated and bound to vfio-pci with PCI_COMMAND=3D0x=
0000, while reporting successful recovery, appears to be a false-success co=
ndition.

Please let me know whether this behavior is already known or whether the ex=
pected fix belongs in vfio-pci?

Regards,
Amit
