Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020086.outbound.protection.outlook.com [52.101.84.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CA336EE1;
	Fri, 10 Apr 2026 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798412; cv=fail; b=PDpxW9lDMQYc41Um39LGfSBEZ10dhH7sMNrs/xyy7nFZsaAsekvThza7/csaJmfx0gOikXTPVQEWMT+PevLmSKXdp84atYUDjceRH5r7QBZqemn9oWLw1Zr8/hFKkowtFuq9IZNTRnKOsksWphfENoMc7JE1YV1KaKVH8W7CZbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798412; c=relaxed/simple;
	bh=sO441g4vc/8whmw5zxqn1sSNXt54KRsLoNekYcTxBLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5+q9b8O9dzQsdaWv2FwqvWDrpi8NXt/5Gws+pusJRjM1lJ1wwW+0axqrIBr+txFVp5kg2GrnzOA/npS/JXuJ81g5xpE3QdtWIjWusxmOhDv1FbCXmxsrp2iivy1LyaptMIiFWQwxwyWUxM/1hFaQnuL0aPyl5ub5516e5DTubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=durst-group.com; spf=pass smtp.mailfrom=durst-group.com; dkim=pass (2048-bit key) header.d=durst-group.com header.i=@durst-group.com header.b=ar11APyP; arc=fail smtp.client-ip=52.101.84.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=durst-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=durst-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=durst-group.com header.i=@durst-group.com header.b="ar11APyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykd60vemyER+mSAxNVMPQc/vvOAaaJdyTZgPPpvtmg9koLKykigmjB4wD9IxlUABEC2kfycvb5K5LIQbYYdchG22wSNIpATZ6+vwIQpL3CWdKnuD3TKQnkQW5UEWPqFZwGmS/RTEh3alPiJO7lp2JvoNCuoLqj5gHtBMGqRqxshc/EOXc2vh+8iEmyGmAiX5bVu20E1hmbufcXLDuKhjQ2h8EAhXSS2xvGMsltZ9afuZcUmCTEmKJrI4gPVnPkpU4/cFPZ7myLJK1KPHK2gv6jjd+8ggM/plAdAV445PFuT5WjB3huzN52D6CyGvcQjG0xN/8wzmJ10Bq0BPTLNE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBYfQvWF1j/9HA0yety6cqvifD0qA3wFROrQbwFWEo8=;
 b=sx6ChCaAgc7O/cQeXoh5RAaCvv+WZO+AcHPEmyGuDY528kr41E3fP/4D6dP2HKTmlDPeqo84l0YJybgyKK0VW0g93sGjBIbU2o6TzAC4CtNcoJfiUrr+ulfmYTPRwG5JKddXnBpK2jv6Qq+X27alr//M4kSh7a3cVx/6y3DqGTTESuxVFivNn+Aco6lfBVGhxBO3EsCJZCDxfeldwruxkPfHFxR5RLvw4NOnVRYh2QVDj3pR3thwQZRbb0uypyykC72bW4rmT/oi2SN486+A8MWpY07VW/bEwxHAOfdmDKoklQkmrC79dhNkycxzsvrtycU8kwkvnfAe8OBzbi1mNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=durst-group.com; dmarc=pass action=none
 header.from=durst-group.com; dkim=pass header.d=durst-group.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=durst-group.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBYfQvWF1j/9HA0yety6cqvifD0qA3wFROrQbwFWEo8=;
 b=ar11APyPBvHklbIr97SE5qqAHLeCRPhnz6qCi7RiXN9rQGw2g0DPYl6V/FdDY9pXWx+QO+wKdKtSeAurj0bmlxcNzvgj91usguG45uYzyxlAQkt0Xyui27fGDgQLXioGatIneQfjvG7lbW9tRDGyUQYz6nPmmGXOFUgHj3UcYL4sTvyWsH6BCpOLxBwTdylv+lOfNeiJsXhDTShBgOtvBfHlsZJ2GtelUkSsNNYT1hKpegzk50GpkdFuXOYwi3knQ1Wp2awK7rD0tu8GnYc0F9UYeEDdTe7UfFQmnCMG4o9T9HMJTlEMf2IiX0DnX6BSdFo0EKCPaQNUs766d7IlLA==
Received: from AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::22)
 by DU4PR10MB8366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 05:20:06 +0000
Received: from AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c01:2554:be0f:71f]) by AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c01:2554:be0f:71f%6]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 05:20:06 +0000
From: Georg Klima <Georg.Klima@durst-group.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thunderbolt@lists.linux.dev" <thunderbolt@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"georg_klima@gmx.at" <georg_klima@gmx.at>, Rene Sapiens
	<rene.sapiens@linux.intel.com>, Alan Borzeszkowski
	<alan.borzeszkowski@linux.intel.com>
Subject: AW: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ
 warning and shutdown failure.
Thread-Topic: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ
 warning and shutdown failure.
Thread-Index: AQHcvRi//eUtQtyfVEWa70RHOTCJXLXQOskAgALtfICABK1Cuw==
Date: Fri, 10 Apr 2026 05:20:06 +0000
Message-ID:
 <AM9PR10MB4231785C02F301161C5B2BA6B7592@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
References:
 <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
 <adIkaExcG-T5XACV@wunner.de> <20260407054151.GC3552@black.igk.intel.com>
In-Reply-To: <20260407054151.GC3552@black.igk.intel.com>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-signature365-signatureinjectedby: OutlookAddIn
x-signature365-messageprocessed: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=durst-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4231:EE_|DU4PR10MB8366:EE_
x-ms-office365-filtering-correlation-id: 2107a616-5d95-481c-0a25-08de96c0d3f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fBCiXeizZoj1b3bN/z82K7uZEJz1RWSs4N5J3Oi1OB3ogRP2CXFqcqt8Cm/jx9dXqD18LA3m9WnUqAxutPgK9JWBTQksyxQ/uh46vTnPeCTNva+rDGzaBj7fBKtXaRNyjdI+pYfOLZkE1G38zum2+8Yp5sG5nf0Rr/8aAZO7quS7BVzdtJrQevJw1lm1ZUJKHaXtM8jeBlMx6xSOvSZF5fwh4UaRo6ev9ToJyUmJDFkiiXKLmejp47Zuj1sSdHjRtwr2LKcWQcqwZu39ymh/r6FCIFW3zkQY6779ZipVXI7IrZs967u5wQnoOAZyNsgrJatNuX8e/1+n+NdcLhLyuGWrwDrewq2fl6swsIcp5D0LqYDGDVXOc3o6re319lkvJtMiAPaRFxODw9KUGG5Q703qYubDnlYD4bA+15SCnAPBl/12iR+VfhYpzfiD50wOxxKWh54Pbx6IvbmU2uT6nHwZXrCIEKoXwn1suFWc+2bne9AlfKaJ6lRz4OATQSWhTGyVvEJNcKAy+V0mjTsH3ApQElmDtsfZ4c+Aj4wlQo7QbLybUEprdcOzGqBS7+qUSSNjGhtXnw/QkWU4q4zYPWuC/weS8Zwv7ierxIvMuPnLaqZDut6o0ACF3MO+3tWWw4lNMcKFKjPJe5gsKuB9GAbmPv+jIbJMIOWWKF0wgCwpOCIMMx0ih8hPpQdp1DDTeW9ANUQGvQgPssGjkDisKwdTYZ3PRzU8sa+tIJ9CHARJPDY7vqNK/8jR7dUZaDiaFsf9gLD3JAmKLZBZl2GRtCo9JEo5RzJ9AUg8quUKzes=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mVnYNWq9rCIL74RsqQXaJMMZ34y1gTiJqg82fXS7G3SHKLQlKp5A1hc7T7?=
 =?iso-8859-1?Q?9z9ZkrcDuY5XYLqORsP6QhTxaRnAZeQdB2OjotmsvazLsAJCt6buZrbPT6?=
 =?iso-8859-1?Q?A+A6i8EpBb4czVeQfpXPMRTQLPmW/s+8FL77U64GBh3ctbsoG5s9gmoVKy?=
 =?iso-8859-1?Q?CarmNI7OHBts3ym7lyi8+AeqVOyvetfkkR6tFpIZ9/gPPKWiWCDj8OxLQy?=
 =?iso-8859-1?Q?XFKZ4q8CaRMPm9g0//3wtv9CFgEid0yYayYaMU+5CrmkLuNBIpb4tfGpBA?=
 =?iso-8859-1?Q?LGtdWZTGWw/RMhrVmbLQWmxYHxY4joKPNoAAIDzyxyyShqz0Ul39/RTonK?=
 =?iso-8859-1?Q?9vuiul3o+WivYaEKSRL5kXlWQsz3fVIQtVLqx7FrmIhqVYtvyaguwId/Fx?=
 =?iso-8859-1?Q?cJ6afg24s0yToE9QiU3Vkx+EP/At5MDIfF37wjms9NPj2VdkiHUYCWSGLN?=
 =?iso-8859-1?Q?bQGqvf048ccP51a8Ee02bByfST/mhbnng/u4gX3m5eykaYddDwNWRctOdk?=
 =?iso-8859-1?Q?vmkrdk80TahXwqmZSgBRb1J4lzCBdjuq/wpySt1Sc/P99r94/u/yNwwan2?=
 =?iso-8859-1?Q?FND2PvAehrdewSoJm8dJcZg2RHdMouEVHWs9lrzfUSOyJNtMXcP6SeVmK6?=
 =?iso-8859-1?Q?nH1GRI4IWL3zPLcvIWhrRHQ3ns3q6mMF+QoSjQpCBkSGZHOGNeFbkmnJyo?=
 =?iso-8859-1?Q?L8GJrdT4zPbl+W5degfUMuCBiHp17gzAl1qjOqFLmnOdH7DXxw7AJHDeqd?=
 =?iso-8859-1?Q?T1fbtz2eXz/SFSllT8Bqf1LvVb4ymX5KUDzRJZ07QLYFm83+wldnC0izYs?=
 =?iso-8859-1?Q?KdTaaToq74XjMb7cBnTAKe2NQkdxRvUFDlGETAgGKg09+4nADyJtlUEeAm?=
 =?iso-8859-1?Q?poW7WtuWK7UhGNDlP8hkv9Odcj+nLvnYfn/xAEUkzL2tvd3TIEQ3eT28HH?=
 =?iso-8859-1?Q?vL1zXLzTdq5AITYIppK89UmTGZJejT+ggRry1OoCMyvJrAz2ULecn4KU47?=
 =?iso-8859-1?Q?GhBsNgcf2WuKYX2NjJcg36iI/evwyBAbdiWztGc2Y4797+k9aZh8uLmRPg?=
 =?iso-8859-1?Q?e8M/xWgl7lSHDchGwD8o+Pae91kTVeQPY+TLkM38Tl7+xQ/ufgJidfPSYP?=
 =?iso-8859-1?Q?yCGBQ7Teq7mB45B3UkjxDCbYinYTnkZq/4+nw7Nm9AAIHLqaCPYbAQ7JOj?=
 =?iso-8859-1?Q?uzcK7vp/NFEMb8WvalunfDdswxTk4qgyvzICtH0Cd9yA7TLcgOrAL1N7c1?=
 =?iso-8859-1?Q?xxKBGxNXGfHaUIMqXtG4n+Qw0hOXlBhPXORwuU1DqicUP8p06gMZq6aCAB?=
 =?iso-8859-1?Q?fJf2cjDcaJuODCX5NOD7FMi0IR1yp8UQxkpvYJTEBhrSEwIXsj7oD9a0W2?=
 =?iso-8859-1?Q?rBU7mT+87rlgZFUGOd8OeNrbZZDhpwFhY+IoG6jYQpLlacOMYznxOsVuDC?=
 =?iso-8859-1?Q?iJEMlOCPjbx1ZJ3Z7+QyAtZqjr6Y4IBBiI+swniPkwLmNB8KFQTxBOI+XP?=
 =?iso-8859-1?Q?gDVkmY9f7KXFimGjEZHJSOTdRLzUwX3XqX4jUNVlxZwHr7fd1hHAVv7uep?=
 =?iso-8859-1?Q?soZfIDLcZUs+mA166Jfrox99ODAdo8s6BGdVL5+7APZc4F2kIg0tWjNbPn?=
 =?iso-8859-1?Q?6eASnLd6osJMqcRyxvbL/hf+4p8IROZRbmv7u85rhMu1WIla7MXADpyv5I?=
 =?iso-8859-1?Q?0XneTii5gqMTOX7oy1rAmc18n/36dncN5wX8y0yGHQ36eJQMUUp+ydCtf7?=
 =?iso-8859-1?Q?kzmBgAsZq1J9vAreN5Lk/wPNh5Anl8lNF0mr5ERzFwJedCa0mw74RibGTX?=
 =?iso-8859-1?Q?PueSGnLOWg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: durst-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107a616-5d95-481c-0a25-08de96c0d3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 05:20:06.6625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3b002d85-b2f9-4e42-99d9-5cc3454e971a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih7zYb6aCqgil/vZPTNIhmJ85NXfYc2rTTlwcqV5N812PC7aS2v2PwLQ6iot106oepnmJzVzwBuuK/mpLDs2t/LZVZLKuPUMgyPykVtAqB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8366

The issue disappears after a BIOS update that changes the PCIe root port Sl=
otCap from HotPlug+ to HotPlug-.
This strongly suggests that the bug is triggered by PCIe hotplug handling (=
pciehp) interacting with runtime PM and Thunderbolt.

Version: N4FET48W (1.29 )
Firmware Revision: 1.13
Release Date: 01/26/2026
was / is not available over fwupdmgr, sorry


SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

80:1b.4 PCI bridge: Intel Corporation 800 Series PCH PCIe Root Port #21 (re=
v 10) (prog-if 00 [Normal decode])
        Subsystem: Lenovo Device 2347
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 128
        IOMMU group: 20
        Bus: primary=3D80, secondary=3D88, subordinate=3Dd8, sec-latency=3D=
0
        I/O behind bridge: [disabled] [16-bit]
        Memory behind bridge: b0000000-b7ffffff [size=3D128M] [32-bit]
        Prefetchable memory behind bridge: 4000000000-4fffffffff [size=3D64=
G] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B=
-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+ TEE-IO-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ T=
ransPend-
                LnkCap: Port #21, Speed 16GT/s, Width x4, ASPM not supporte=
d
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltM=
odeDis-
                LnkSta: Speed 16GT/s, Width x4
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Su=
rprise-
                        Slot #25, PowerLimit 25W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPI=
rq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- In=
terlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ I=
nterlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+=
 CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPr=
P- LTR+
                         10BitTagComp+ 10BitTagReq- OBFF Via WAKE#, ExtFmt+=
 EETLPPrefix+, MaxEETLPPrefixes 2
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp- ExtTPHC=
omp- ARIFwd+
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIF=
wd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Reti=
mer+ 2Retimers+ DRS-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedD=
is-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0=
dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+ LinkEquali=
zationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported, Flt=
Mode-
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee002b8  Data: 0000
        Capabilities: [98] Subsystem: Lenovo Device 2347
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECR=
CChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [220 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd+ EgressCtrl- DirectTrans-
                ACSCtl: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd+ EgressCtrl- DirectTrans-
        Capabilities: [a30 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [a90 v1] Data Link Feature <?>
        Capabilities: [a9c v1] Physical Layer 16.0 GT/s
                Phy16Sta: EquComplete+ EquPhase1+ EquPhase2+ EquPhase3+ Lin=
kEquRequest-
        Capabilities: [edc v1] Lane Margining at the Receiver
                PortCap: Uses Driver-
                PortSta: MargReady+ MargSoftReady-
        Kernel driver in use: pcieport
        Kernel modules: shpchp

________________________________________
Von: Mika Westerberg <mika.westerberg@linux.intel.com>
Gesendet: Dienstag, 7. April 2026 07:41
An: Lukas Wunner <lukas@wunner.de>
Cc: Georg Klima <Georg.Klima@durst-group.com>; linux-pci@vger.kernel.org <l=
inux-pci@vger.kernel.org>; thunderbolt@lists.linux.dev <thunderbolt@lists.l=
inux.dev>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; geo=
rg_klima@gmx.at <georg_klima@gmx.at>; Rene Sapiens <rene.sapiens@linux.inte=
l.com>; Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Betreff: Re: [BUG] Thunderbolt runtime resume during PCIe removal causes IR=
Q warning and shutdown failure.

[Sie erhalten nicht h=E4ufig E-Mails von mika.westerberg@linux.intel.com. W=
eitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.=
ms/LearnAboutSenderIdentification ]

Hi,

On Sun, Apr 05, 2026 at 10:59:20AM +0200, Lukas Wunner wrote:
> [cc +=3D Mika, Rene, Alan; start of thread is here:
> https://lore.kernel.org/all/AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR1=
0MB4231.EURPRD10.PROD.OUTLOOK.COM/
> ]
>
> On Thu, Mar 26, 2026 at 04:09:05PM +0000, Georg Klima wrote:
> > I am reporting a reproducible shutdown issue involving Thunderbolt,
> > PCIe hotplug, and runtime PM on a Lenovo ThinkPad P16.
> > System fails to power off cleanly when PCIe ASPM is enabled.
> > After the kernel prints "Power off", it emits warnings and does not
> > complete shutdown.
>
> The dmesg output shows that the problems start much earlier than
> on shutdown:  The discrete "Barlow Ridge" Thunderbolt controller
> is hot-removed at the 08:44:29 timestamp in a noisy fashion:
>
> > Mar 26 08:44:28 fedora kernel: usb 3-3: reset full-speed USB device num=
ber 2 using xhci_hcd
> > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer L=
ink Active not set in 100 msec
> > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25):=
 Card not present
> > Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> > Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for =
TX ring 0 is already enabled
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not re=
ady at resume -19
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume e=
rror -19!
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: HC died; cleaning=
 up
> > Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 a=
t ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/109=
2
>
> The controller is then re-discovered after the link goes back up.
> The actual shutdown doesn't seem to start until the 08:45:26 timestamp.
>
> Going forward please use "dmesg" to collect kernel output, not journalctl=
,
> so that we get timestamps with usec granularity.
>
> >   *   Hardware: Lenovo ThinkPad P16 (21RQ003BGE)
> >   *   BIOS: N4FET30W (1.11) 10/03/2025
> >   *   Kernel: 6.19.10-200.fc43.x86_64
> >   *   Distribution: Fedora 43
> >   *   Platform: Intel (Meteor Lake)
> >   *   Thunderbolt controller: 0000:8a:00.0
>
> It looks like this isn't Meteor Lake but Arrow Lake-S:
>
> 0000:80:1b.4 - Arrow Lake-S (800 Series) PCH Root Port #21
>   0000:88:00.0 - Barlow Ridge Upstream Port
>     0000:89:00.0 - Barlow Ridge Downstream Port to NHI
>       0000:8a:00.0 - Barlow Ridge NHI
>

Looking at the dmesg there is hotplug enabled for the PCIe root port:

  Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot #25 At=
tnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl=
+ IbPresDis- LLActRep+

For Barlow Ridge it should be disabled. Lenovo may already have a BIOS fix
please check. They have done that for other models too.
