Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011066.outbound.protection.outlook.com [52.103.23.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981A2AE7A
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638031; cv=fail; b=Wg8c2GF6BYf6tXwoMVrprf3gWgouWED2fI0XHuCCktZL29hMFCO3VHavNmADP8yQlU03TzJl4xVmR9XThuIrdDZgAUEBLAAJLJqcn7LCtymsYN2Wi5bPZW8YBchBE/qPaYNESTqAa+WOHW6xqyfnqrXX1nL8pF6ZQxfn/rPgwag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638031; c=relaxed/simple;
	bh=EmYskcTTetv8skvD6ef4RHfCd1yKeKKkB6aiRG6aUPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QiNHnVkr4bfwBXcf4QXdHCnmawUBlasRuLa4089kfDR6pWyu7NHidSoVjsGjBDJiyHzSv/WgyfcNMDc5SeInsrwb82EUSad/+9orSQvyfCp+Uluu+0Nc6k/Zwy6aVEfpiEtXpKvT48rDJiBla5IbKXFi1QdA+KtnkpboncdAr4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dWWpfUqh; arc=fail smtp.client-ip=52.103.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dWWpfUqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m72eO2jr8mZ2VQUCTUsYIb8RghLwfbdgcSFsny1ATs4lOnFZE1sqA8u3dUWToIWBsuzBxSOzl4KruiUVyjxgVGYK9E2k7rzwPebPpW2Y1WvnYJVVvHW9bUL4KV9fHPOyGO1DhB0DNLt/TUe/Yf+P8IYKTXji46AsNSIozVicRiuXOz5uxrqG5D7af7sC8PEr2ZZ1Zz0BRSxMj6OVwTkqia7STb6VOlSRf6ycdND83aPdhRrRvHfGHw/E8x59v8OawgGj710UApyNtE7p19pTA2Je5LYkxX9wkvP2rbLdx9Y1Gf46r/Q1W5JDh3oPZG8GOhlL2uzkubbJ5Wf2brvkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dH7k0uClFg390wwx0zBtKhceDIGus4pd2/74OXrhAI=;
 b=BFuLJ9xnippcXAX77JBR2qsazEkxWT5vQgdAlyDPXWlPcfInKwoLYdnrugMMKx0raFkoKhqMNhns92CPWKj8+PU3kWbWdLBFhTRvxLBNNFEJPbNl3dnhXpA5vGc9JQZ2I2v8ytzoOMBgUA0M2ZYl4c4q3Mscv9Abz5Zf0zTJ3kvXPOo8gRDI5mXjxXqpqIxSQw5AcszRKX8ExyDbZepbxu/lJWqs6ighmp3B+mxCcXYbuuAUy8uWnZIx9zu4gwqeuCwQG63ON723BvAAXnHcTSeU9qr0ugzxDwSR3hYugImb6Bs0i164M6IOW31luIos+P3su9F39PhX9XunUCY8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dH7k0uClFg390wwx0zBtKhceDIGus4pd2/74OXrhAI=;
 b=dWWpfUqhe8pXfWuV66s7it9VFkNDPrybpU4xrqROwl21MUbayJ9QjhcXrt3yOJ/+nz7KjNwA31eKvdl2VEmbV8rBoeglAAFhW0vs7RqOeF9By64C3nYoWQjb1GqIhnteXgzLi/8/rHgWgHJPQdq4775UTQfZk8/JhfDeRl8bOg2fnGrjPN7Kkzg6KI72hrEsI+cLQdsioRneS0uXSLOHisQEXYGreu/YtlDtYr3DnnwOpYs/37qibMuQLY6KbaiU1hq7htzvWOrwsDG9GJQ5voQ3LBQBCWUxwKIfOYhi7Lgf9hTTMg5neIbWZvlT/zQspDbAio+iVpijnvJgjQkG+Q==
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:485::15)
 by DS4PPFF31B32C29.NAMP221.PROD.OUTLOOK.COM (2603:10b6:f:fc00::ddd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:47:07 +0000
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186]) by SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 12:47:07 +0000
From: Lin Mohan <linmhwork@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Ali Alaei <ali.alaei.tabatabaei@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Topic: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Index: AQHdGJnKcWiEsmMH2UW8ztntKdAIeLZ37MyA
Date: Tue, 21 Jul 2026 12:47:07 +0000
Message-ID: <466A6B8D-3C77-4E14-85FC-3EFADE104F80@outlook.com>
References: <20260720224745.GA435004@bhelgaas>
In-Reply-To: <20260720224745.GA435004@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P221MB0955:EE_|DS4PPFF31B32C29:EE_
x-ms-office365-filtering-correlation-id: f563b870-af45-4504-0225-08dee7262c94
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|15080799012|8022599003|12121999013|25010399006|8062599012|41001999006|19101099003|31061999003|19110799012|3412199025|4302099013|440099028|102099032|10035399007|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kr5h9YP7k6enNoWTuwOvrY95X8hu4/uoGATcbfEgsiZZgstRdkEq99K4KUFr?=
 =?us-ascii?Q?29N7Vnb5ezTNhmLZPwLv+BxfD5ie6j3Ls7F4SENn24Db28nACUhzg0LHn/2n?=
 =?us-ascii?Q?4Pkx90h9iw7WxzRT85tPWm5o/tQASozi9HiFdbimkCuJ8FVil9SHIGYWfZo0?=
 =?us-ascii?Q?4ewaMBse87ZXv4tH5rKvJPtj7/Q0pTwTH4zpKXx7Pu9yOswJY+gtbNEVcmsL?=
 =?us-ascii?Q?MIpLIeYz/EUsDHYoRnBOrVJn5gUUoVrt03kEiEsjK1kOD4+ruysAhUnKUgEL?=
 =?us-ascii?Q?ImiijbDGzJsGjpKcpGhmRx2J7qZZqUYVmkJKICTixQ8NkvTphn3LQXucIh+g?=
 =?us-ascii?Q?te12fekeLh8F5f+08fAyZ2I4VynPhhjLEpKvbHsSfWaizcEpwyZk5lcijFru?=
 =?us-ascii?Q?ucKsbzPYpO4Hod9hQgwC9p3CkAEnc3Heu8eoUMiAdXcJr3/DGj8f0lGzWdWP?=
 =?us-ascii?Q?xKMnu/HRtBt0g7KsgbwZ/geGLO0D//OIvD0Lqv//R7nwgDtiSdqL0MhpD4vX?=
 =?us-ascii?Q?/G2APCalD0Zq3PF/ZRzVJnnR4Fkfv29XhQ00grJO5kMNpUHGuk5wOZ1659be?=
 =?us-ascii?Q?Ccw6MCJadHMdLDil5yywrC2orTnnuzq4LV1FkOfs9f2WUrI52+xDmdaYviMq?=
 =?us-ascii?Q?lxLCza+cOVKuTujDpUBSWnkNYRWWy5zNWx8mRH4RxAurDU3Z21uIpakMbPeo?=
 =?us-ascii?Q?8OeDKcN4Q7WHAwQLgqfvFmOjRdrau/GJ8tDWq7LiqYp2Ma7MKEBc9zoNYjzQ?=
 =?us-ascii?Q?qSDWwAJ/ZFpgVo06IKkqEGQXI4qZdD21QUFbruXQWuHn6TzYQIYIjMnhp0zn?=
 =?us-ascii?Q?cOvn/8GP83GGE9G2B9EWvt+WyQzB7mxpR1WFAZJLx6F705eRa5xwWaBwCInn?=
 =?us-ascii?Q?L+xPvTufz7CQEI9faY2wgBk6P+x39qP6hrWCfN5StkfAhhxNVwmizMGtt0ko?=
 =?us-ascii?Q?sVQ4WYfCFpegcAtPuA8NOJLCvUzwH2XmzuitqizedtxqY+5c51oBzqIwsVuv?=
 =?us-ascii?Q?6yhZjoyLrXnEiTYLmlD/PC/qnATmxX/r2cjHplo/hjJtH5ifwuzRsuSFlBXm?=
 =?us-ascii?Q?zaNz8Is2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aRN5Er1dLRKDRvZeRn6+FxuiDRXRhhWogT83V3qXQYQsT9iba+kxlmOti+QL?=
 =?us-ascii?Q?fX2hh0PGCUYTxzpYsHlUAHRvF4e2VpQLtBnLYI19DFL5QgLoAUUK7mmn+JWh?=
 =?us-ascii?Q?p7nR2EsmWq3vIQWoghJPhmRc2L4tRE9tsfdS5Aqd+PbetFh4TSUDWpdRvDXc?=
 =?us-ascii?Q?AETkC+stZpWtEukNEAnFWawnDt6DsV0E95Xfhk42QijbnatmIO4Eaxqms8Hj?=
 =?us-ascii?Q?pbAcEApp4s3J+TACx7afd5BTD6I6EtA0CyKGlquybN9OWHALvjl1LMH/FP4H?=
 =?us-ascii?Q?7P5mFLwzNI+IIu380zlA03DwfRUcX5AgYTNSSopU6OTOvxYFk30rMJ695hUi?=
 =?us-ascii?Q?87TcqViJH0SaV6Hw/Q4Abvay1gET2B8ma1/XyaI4/PFEia7SQ1b0+WOGCSXf?=
 =?us-ascii?Q?vyxMaqZsMlKr0EGRzoCgfbCMyU41NFpxUqFU7oA2X+OOC0sa6BqWm5AMwReF?=
 =?us-ascii?Q?aKq+Hhvp2iTs/l2wYsb5LqLw2FWADyRKT7OrqJyOFv8N43VjJiiJtVj6Ff2v?=
 =?us-ascii?Q?esb4JQ0YBZ3SHft4oFyDmvlVWnBSf6e/gSnHsnuAsvpOMntvMiQRyefGJR00?=
 =?us-ascii?Q?6vgXDh4EqE5h7FEDBn4jnw8anDLGRBbPv3Cq+n1/SmbGh72E4zrsdRN6wO5f?=
 =?us-ascii?Q?lE6TGs5TjL8scXH9vv0cMY3l2FPka5mn4caTwBoLhf1YRtW/XDzyF6gCrys/?=
 =?us-ascii?Q?x2G0bHb5gfgsRykkOudo6H6bXXfhFDpWM8d1S5CSGJm14eb0VYBPIhMdqHib?=
 =?us-ascii?Q?0DpbRFdxAqvVjQXe7kyu/nri7hmG2nKO9XFUzNswir1tHocq27VpfAkX2/Vp?=
 =?us-ascii?Q?B9kEoc5z/DiWjkAtNUX6+p4focKJ6smarfjn2ffqAnLUbJc4tFpYdwq7+PoU?=
 =?us-ascii?Q?nTJCDuBuYX2wTaLZHpx9mslE5A2bnSRxPKwjrGa7+VgOemH4Jvr5/v3i7nRv?=
 =?us-ascii?Q?Jr2fTIpYaH6pI0CzPdTUsoqWON8w6b+ew0zsxBJXC6uZmyY3ct7PPo3M3LJG?=
 =?us-ascii?Q?CQCFJ0LLHkwejypJckjfHqSREpmb0mnBiOLJtWI+vHqD5h3Gw6dBrYwYsdG5?=
 =?us-ascii?Q?MRx35U8GcrM+S/q4BVNiJxhGJ218K9yq2lIQ2NC/LvYRBEfsQG8351Xk81eh?=
 =?us-ascii?Q?mG65XJgzZxx578IK/AQi49PYjXX07MEdKxfyg+9fCSX4/INoujgvo68bgsFT?=
 =?us-ascii?Q?jkAt+dKXhernyGSPwf3zT57R9KV1r4kTDMLY/1NMVx2U2l1cmL3ZMBsJSXAC?=
 =?us-ascii?Q?Y2FwGJHTV8rO4Aa+L8GSEdZjpPWBCwu/j6fRwBHq8ykYcFAVupqkZd61XqHI?=
 =?us-ascii?Q?m67in5ZBI0FS1vd8fcd4nz4LHrLtgok27mgBhQdQgyOM3aIqi1x3/Fmo3t8O?=
 =?us-ascii?Q?v5AhxJiaiEErSOuBH841Ao/1pQ7S?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8796250A295758419BA6DC86A41FB1D5@NAMP221.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f563b870-af45-4504-0225-08dee7262c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:47:07.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF31B32C29



> On Jul 21, 2026, at 06:47, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> On Sun, Jun 28, 2026 at 04:34:50PM +0200, Ali Alaei wrote:
>> On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
>> PH16-73), the VMD controller reports BUS_RESTRICT_CFG =3D 3 in the VMCON=
FIG
>> register. The existing switch statement only handled values 0, 1, and 2,
>> causing vmd_get_bus_number_start() to return -ENODEV and aborting the
>> entire VMD probe. This leaves NVMe drives behind the VMD controller
>> invisible to the kernel.
>>=20
>> Hardware registers (VMCAP/VMCONFIG at offsets 0x40/0x44):
>>  VMD 0000:00:0e.0 (8086:ad0b): VMCAP=3D0x000f, VMCONFIG=3D0x03b8
>>  BUS_RESTRICT_CFG(0x03b8) =3D (0x03b8 >> 8) & 0x3 =3D 3
>>=20
>> Add cfg=3D3 as a fallthrough to cfg=3D2, setting busn_start=3D224, which=
 is
>> the correct bus number base for this hardware.
>>=20
>> Also add a PCI_POSSIBLE_ERROR() guard after reading VMCONFIG: a failed
>> config space read returns 0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) =3D 3,
>> so without this guard a removed or errored device would falsely match
>> the new case 3 instead of being caught as an error.
>=20
> I suppose this should fix
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221136, which is a problem
> on an Arrow-Lake-S system?  I bcc'd the reporter, and we could add a
> Reported-by: and/or Closes: tag if appropriate.
>=20
> That report mentions a 8086:09ab VMD device, and it looks like this
> patch addresses a 8086:ad0b device.  I suppose there are lots of VMD
> devices IDs that appear in lots of systems and implement this feature,
> which the bugzilla suggests is called "Dynamic Bus Offset".
>=20
> Given that this is apparently a new VMD mode, AFAIK there is no public
> hardware spec for this, and the patch doesn't add any new code (and I
> would expect a new feature to require some new code), it would really
> be nice to have the Intel VMD maintainers chime in here.
>=20
>> Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
>> ---
>> Changes in v3:
>> - Move changelog to after '---' (was incorrectly in commit message body)
>> - Add missing VMD maintainers to CC (Nirmal Patel, Jonathan Derrick)
>>=20
>> Changes in v2:
>> - Add PCI_POSSIBLE_ERROR() guard after VMCONFIG read to prevent a
>>   failed config read (0xFFFF) from falsely matching case 3
>>=20
>> drivers/pci/controller/vmd.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index xxxxxxx..yyyyyyy 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -640,6 +640,8 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
vmd)
>> pci_read_config_word(dev, PCI_REG_VMCAP, &reg);
>> if (BUS_RESTRICT_CAP(reg)) {
>> pci_read_config_word(dev, PCI_REG_VMCONFIG, &reg);
>> + if (PCI_POSSIBLE_ERROR(reg))
>> + return -ENODEV;
>>=20
>> switch (BUS_RESTRICT_CFG(reg)) {
>> case 0:
>> @@ -651,6 +653,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
vmd)
>> case 1:
>> vmd->busn_start =3D 128;
>> break;
>> + case 3:
>> case 2:
>> vmd->busn_start =3D 224;
>> break;
>> --
>> 2.49.0
Hi Bjorn,

I am Lin Mohan, the reporter of
https://bugzilla.kernel.org/show_bug.cgi?id=3D221137.

Since commit 22b47bd49e45 ("PCI: vmd: Handle BUS_RESTRICT_CFG value 3
for Arrow Lake-HX") has already been merged, could you please add the
following tags in a follow-up fix?

Reported-by: Lin Mohan <linmhwork@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221137
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221136

This patch fixes the same Mode 3 / Dynamic Bus Offset issue I
reported on the 8086:09ab VMD device (Arrow Lake-S).

Thanks,
Lin Mohan

