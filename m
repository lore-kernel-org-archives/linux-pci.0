Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010017.outbound.protection.outlook.com [52.103.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402D30C164;
	Sat, 19 Sep 2026 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821584; cv=fail; b=g1vHUGRRdwdFtnG7jci4q6RRlhK4lksZB/xf6CCRXM2QEGTOKtz5q9fmhtlwHsFWgdSanm3zfdXw5lNJLczRw2BqYn+Ct2H4X6RnJ9ndLGa3KiL94sS3wFzpkQtCvD4aeUkJXvPhsLcE3WKsSBaTbvxEOnCW37y3tCsCN3Amp6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821584; c=relaxed/simple;
	bh=jpZ2E9g9uO4b7JfZHQ0Aho14LEIIlRRcI6l6MTRScwo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T4Tawrsu63/j2LRGHBYH2xJxpWdXoWNtIOyT1Bzs4ljPCs8oquWaI47B9s1ai/1NCdNoN3muGM/pzgU8ANm3nmszXH2VXXGNDejtnDLMF82+RL4Ztx2Zkq7CCvva23PzbYkjfSXmJOHX8CQdM7spmNGAOFsaf8wihSgq8YR1olY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pOmyP9x6; arc=fail smtp.client-ip=52.103.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pOmyP9x6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRm3MTt0F/NSfC3z8Td0WtHMqBNFk6cE20e8V7fcA0k8Zl1epvulPKk7f0eT6qFDzwMKbzXWKfCBwZ7P7UY+b6/3KUcUpg6Nw6/f/YLXHTWNiQNCBUlbCelDMEXxSGQiI/7gvHhkO6GM5p5OqgRwhy18yucL0JJ9UqJ8s6U4gFIMiMIacDLxIh7iSniuV7YN4venV/V/kwztmuIESQgk9cwJPvi2Z6t494v58Deqzig3FvEzZlpUyfUiWj3X9wW56LuqAo1fUSiAxduZP9Czx694MdIdUfX4kBtYyo26m2tbeCIoDwBKCREqL6qcolZlgQ1GNZ1DCNx2qFVkQrrUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpZ2E9g9uO4b7JfZHQ0Aho14LEIIlRRcI6l6MTRScwo=;
 b=xPYgKL/SUbsLRxc1rLhjuwB7MstEoWHcVTeQZfnroSqVdX+i4maC+ku5SUGxIb7gcy23lfBLCSNihteWm/XybCmcREuda1PRisYeDoeKu2qImyHNt84bgyvyGBKxVhxX9gavDnmzlFVMr/300jIkyw5wxkpjZDXIFB8GEajSfJrAvJtQVMacJnZIkxfJQJPGlOcU1Zzse99S13cz5fqy9Ty/Kd+OcWwaXgCZO8dZ/UGSz2Uh/6/cyrxi7fXZPmQuk2wDe/o5vuc/NAcuvKMRA6YKhopwe7pTel7AlKYFurxZYBgQ1Qh2IFrKM2roXLkBfp7Swiqgh9EMQmAta+3Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpZ2E9g9uO4b7JfZHQ0Aho14LEIIlRRcI6l6MTRScwo=;
 b=pOmyP9x62fP4hwuoqd6BD3AXZWySSNkNZpfmngfEHB3PXGYzlAAy+2weTqoDOHGNepdw0LwuUhYspJjviuIGwG8ywVqvs3dFVJ59bYx/AQFhbDnNBQM0uhY+qgvepDst9dVxtPqnBR1jvBUoR/XmP4JV+BfAA5hNOWYJ53gXkBSQX0JEHj+VTILbQBze2I0JCtUy7yrU0JZZwkCOoygIDKoQeAYKAVgIlR93srDYrPCJQ12bGakzwcqmU+ubrudg1NKaMlsIt6QdJNNqSkWkw1lvTuKR+33MWNJZ7l1gDV4VC2gGsQVcGcDzfosJqDd//ehT5jwpaJZgzHINkabOwA==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TY4PR01MB13886.jpnprd01.prod.outlook.com
 (2603:1096:405:1f9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 12:39:38 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 12:39:38 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index: AQHdSDNPea4qqw1tcEOkT/edQjHT9g==
Date: Sat, 19 Sep 2026 12:39:37 +0000
Message-ID:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TY4PR01MB13886:EE_
x-ms-office365-filtering-correlation-id: ada9f2c7-ce75-405f-6e44-08df164b116c
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzYMDyXLQkgUaCYjF6hsLC12K458kLotPhGVe2YLq+RvoIc1b7JIw73Md051m/GjJKqdhZTnW1jhFBzDt+QiKI9bpMH4q1n2hcZp20o5cv2EY0/S6w4+oc9fvZoLcXk8U2Eu1e8tVjn9JwXrhqfM+xQDAnoJpendawTFlZveG57PkUtZQv8R8G65KzyNEQnj4k/Hl8O/bUELnXJVUng8oYkeTfZ9uCx3LalB0G4ViSgvAtyfYltIMSVdgcAKCtv0RPgkF6LZtKIk0WJNscSW6PYATPMcDapDrmm5t1/knj4oWVR8g55UFKxJzOBHwd73vdHMesmov7ebTXlv8JaJPP+TfuOKiRCdYX+yFrI70T9YtRWShh2o0pILwzLcOPkkRZ1WlIpxINE+0pdFYZ1YY5Bvb9m26fMWHTXhLpQWki9GJB545KIz0j0+A5mAWnggku9w0CdYQBWy1JJMDqamx4BqmP+lbxLlOYFkZOCth7vF0gUgYorXT6XRNKsKkzUe8F3OF2yMLK5CfilImodQIrcQcie9IJ7q9WlTMTAndZAKUbaPsqk0MLSoqx14YBarXGl7hRtE3Mbet0yXoM+93+PgDT7xkFKcoF2BgyGGvFvh2u8QcUJ6/ZMSCNjk4AozAqHebmdJv/DWTdyC2o0I58YauU5PQ9W7Il9Bi5UgBTb171yObw4g57uQPe9Y6Hr7obrwqwkdjTJ2RI0PAHbLn7xAqGJPZ7KfAzAZuDnNj9iAZH7pZQqp72Y2A4qVs4RrClPG/qIlktCdnDQjvP/QIwMI
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|15080799012|24021099003|8060799015|19110799012|8062599012|31061999003|51005399006|25010399006|41001999006|3412199025|440099028|26104999009|102099032|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GyfqnJUWKCv38glY25HgPDMiS31/OkHOMMEPudFaGRxtT7BAmKUJAsok93?=
 =?iso-8859-1?Q?LEPXbiH1dahLIWmSL7YZEQXJFjOKJQrhLOuLdewnS9sW0A2wICE9OfIurL?=
 =?iso-8859-1?Q?y+XCXkoShYeWxAuTxenR9AKn+GYMm0TMpeD1qdfR0ksWtVGS1i6BfjNw+x?=
 =?iso-8859-1?Q?BiUgKBbRsVuEijfzAvWJ6Kq8ar7IAw4ROqrlwfPqg2/xPHxeepS9i/Ci4l?=
 =?iso-8859-1?Q?lwH5ZIg4YQ+EGiyH//F9OykqRqb4Sbyi5NymMFH0lnrTNdyRS3K3UB2KSC?=
 =?iso-8859-1?Q?AWqt7rk/K/Bct7E9z4Q6R1d9x16DWuTIrB0bFVCoEA9RTrI4BAyZI1+V3V?=
 =?iso-8859-1?Q?M2e1wpL+tppd0U1iApJnCWtaxMq1kf5mvXLsGRVcBRcISea3Y43LBONEw9?=
 =?iso-8859-1?Q?wSFVsEkojuO/bezwtTS8bH8tKbVU27jfoAD1ln7uStcC8QtApwaiFGNrRZ?=
 =?iso-8859-1?Q?J2dweeRRpD1MzhOFFFEYLG1+ZN82AaT8OlOwYAnKkEU5YfQ3mAMo+9GLIl?=
 =?iso-8859-1?Q?61epYDBd4NFWGfafj/mKxTadwMV+pAoX7YlDrUbBJ27nsoh+pYr7v3Dddj?=
 =?iso-8859-1?Q?cK5gDO1DbPIM9C/mwal/ksLBmxxBW7YF0XlPrmZytHKbSsdQIJPsfjVJ3I?=
 =?iso-8859-1?Q?JjthH+M2/R5b2AXo1xmTBe0Jst4AQ7RvXqQFd2uvvqGEO6LFLK+dyiLteT?=
 =?iso-8859-1?Q?ioW6A1TMBEJLYuoVUN7fDcI+HIjafbFGYMYmT3vJs6Ndx3Arb+5l61NDoC?=
 =?iso-8859-1?Q?DoIDFuof6E8Lh72w60Epzpl/mBydHPs4Qp7PepApFrfc+r7SUXNywwk/yp?=
 =?iso-8859-1?Q?axNXGU5uKn/1fJswMuGuxEOHt5puD44FLSfoamI4aoP8TbAfL8MYypQjfS?=
 =?iso-8859-1?Q?i1bQIuo2Q8yWeoNyHHLJJYdi+lCfhHxF3BYfK63YJ8OCVcMkH5j27wzBPy?=
 =?iso-8859-1?Q?/XvikWsNpY+DqnrWxY5sjM4u/teZfi8uu/0CVK2CWc+fhKQ9AlDljqFqOb?=
 =?iso-8859-1?Q?AKGEmwQlqISr6Zg7A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YQjOKRP6PA7UUB3I8xR5+4MQ5t+drFAaLc/ULw3geHTqUycEeLJofndwZs?=
 =?iso-8859-1?Q?998c8OWsDPFvg1FDMJNXeVgy0ZXnkhR58+Ulw/wOABJHptPeFpV8sZrq11?=
 =?iso-8859-1?Q?huXshm6+dlgEv7nkUpBY5KObpShzhWeeanpgNJv8WOyXOVhs6ps2+dBdL4?=
 =?iso-8859-1?Q?8dSHU9EdcuX869SzOuFvVjygJpHD/VtHTkY/G5x4qXJETAvIXwjw+LeGUD?=
 =?iso-8859-1?Q?SHQ/cHA4YcKTSFhEU54t3uyE5lsxi0+cfqGhu5sLwrcXPYgUK0hEbbRA23?=
 =?iso-8859-1?Q?MAyr2OFAYZEaUeD4y7qEJrs50T1BEyweri5opY5BKxM8xiclxpklgC0Umc?=
 =?iso-8859-1?Q?J6+Jnb8FKCjenzzL2lH7CBawYabSv4hXJgWBEeLdouQXeX9vN8o7m9bbh2?=
 =?iso-8859-1?Q?SRHFcnYXapRestYbxTGJnmW9UMiJLRtHZYVakH8b5WRzIjDMk1ju/u9qkz?=
 =?iso-8859-1?Q?36rRPgu3oG89LbGBN3jE0Y9ptjWgge57Npj4KVwfIzXUrZb8mRirNXo+M6?=
 =?iso-8859-1?Q?HVqCe+SIolF5R5Evm6kCvhNMrytE30cHn+zpuw6FR2ZaxZxrCNtpOOX+3B?=
 =?iso-8859-1?Q?8ix11tzWhFYqF8SM3TaJlS94zwSpYZO5zDuPlbnq94tVhUPx5i4CJx5Krn?=
 =?iso-8859-1?Q?y+E6GIPotT3J4b7a7Uu8UV224EPVBJbCePiD1EN5OWtxMVlnjl5KeOWzln?=
 =?iso-8859-1?Q?MMmcuMtb5Z/9LKH18C/AibrTGurPv3szEH7H9sMiSSo6zgN5k+Z9ZkPwMK?=
 =?iso-8859-1?Q?dLBgX4KwcU071EJ3PJc+IfN9cgbx0PWrfRWVBgK6F1E6KsT9t5B8cPOJp5?=
 =?iso-8859-1?Q?9zPhpp0Fh30rBxQShstFonuhDQUNhqvd+Lk53dy3iFHkQfYLlQ9wYHY4cA?=
 =?iso-8859-1?Q?iYXRpK1X5sNZJqaiK1ItiQPi6Wtj5g8194JPD1Q1ZjeFkhqVs335kjBZG0?=
 =?iso-8859-1?Q?zCz/b6pAixKVU+o1qwYuNaNPwpwMdWnkeOR0gWuNXeuI1GmAU2JPhIZAB5?=
 =?iso-8859-1?Q?Uag81BBZ4388QScXP2V36Bo0Wb4363KbLspFhEG+6MWwoIrDL95DEvcR6r?=
 =?iso-8859-1?Q?LrpRy5o9RQUeXTxxzyQOlv3oZYQ2q3jQt3jcMW806Zv4TIwXUC/dTp0me/?=
 =?iso-8859-1?Q?qlRLJYu3akYa3fyS8xWG03MuPXWoZk28CPXZRg6Mc6VI2naTSeQ7ZKqnNZ?=
 =?iso-8859-1?Q?00mOPoEs2RsFmYVuIkAzWRNY8l9/U63NcX3HjC22Uzvt049qAGoJaXnVIh?=
 =?iso-8859-1?Q?DOJrtLSlWLYBo+Z2vcjSjSL9nzobRyDYFaLQC6nvlAjA2+9rez59WrHA9B?=
 =?iso-8859-1?Q?PJvQqAUR1cbfCffKaF1iwT/eKFq0XJmqq+HfNu4fuJBi3oo9o29tkhAziA?=
 =?iso-8859-1?Q?vIclafuTc10hEWGzFduR9u6XBGBPixk8UyS8VggOfJ9BCE1oS/suo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ada9f2c7-ce75-405f-6e44-08df164b116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2026 12:39:37.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13886

Hello,=0A=
=0A=
I am seeing a reproducible USB4/PCIe runtime-PM problem on an ASUS ROG=0A=
Flow X13 GV302XV (Ryzen 9 7940HS / Phoenix) with a Kensington SD5000T5=0A=
EQ Thunderbolt 5 dock connected to the laptop's USB4 host port.=0A=
=0A=
The failure is reproducible with the official Arch Linux Live ISO using=0A=
Arch's stock `linux` kernel:=0A=
=0A=
=A0 =A0 7.2.2-arch1-1=0A=
=0A=
I have not yet tested a self-built kernel.org mainline/vanilla kernel.=0A=
I can test patches, or collect additional traces if requested.=0A=
=0A=
Summary=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The AMD Family 19h USB4/Thunderbolt PCIe tunnel at 0000:00:04.1=0A=
(1022:14ef) runtime-suspends while the Thunderbolt dock is connected.=0A=
=0A=
In the failure state:=0A=
=0A=
=A0 =A0 /sys/bus/pci/devices/0000:00:04.1/power/control=0A=
=A0 =A0 =A0 =A0 auto=0A=
=0A=
=A0 =A0 /sys/bus/pci/devices/0000:00:04.1/power/runtime_status=0A=
=A0 =A0 =A0 =A0 suspended=0A=
=0A=
=A0 =A0 /sys/bus/pci/devices/0000:09:00.0=0A=
=A0 =A0 =A0 =A0 does not exist=0A=
=0A=
The Thunderbolt subsystem does detect the dock itself, but the=0A=
downstream Intel JHL9480/Barlow Ridge PCIe hierarchy is absent.=0A=
=0A=
Without running lspci, I execute only:=0A=
=0A=
=A0 =A0 echo on > /sys/bus/pci/devices/0000:00:04.1/power/control=0A=
=0A=
Immediately afterwards:=0A=
=0A=
=A0 =A0 /sys/bus/pci/devices/0000:00:04.1/power/runtime_status=0A=
=A0 =A0 =A0 =A0 active=0A=
=0A=
=A0 =A0 /sys/bus/pci/devices/0000:09:00.0=0A=
=A0 =A0 =A0 =A0 exists=0A=
=0A=
and the downstream JHL9480 hierarchy, USB peripherals, and Ethernet=0A=
adapter behind the dock become available.=0A=
=0A=
Reading PCI configuration space with:=0A=
=0A=
=A0 =A0 lspci >/dev/null=0A=
=0A=
also wakes the topology, which is how I first noticed the issue.=0A=
=0A=
Hardware=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Laptop:=0A=
=A0 =A0 ASUS ROG Flow X13 GV302XV=0A=
=A0 =A0 AMD Ryzen 9 7940HS (Phoenix)=0A=
=A0 =A0 AMD Radeon 780M iGPU=0A=
=A0 =A0 NVIDIA GeForce RTX 4060 Laptop GPU=0A=
=0A=
Dock:=0A=
=A0 =A0 Kensington SD5000T5 EQ Thunderbolt 5 dock=0A=
=A0 =A0 Connected through the laptop's AMD Phoenix USB4 host port=0A=
=0A=
Recovered PCI topology identifies:=0A=
=0A=
=A0 =A0 00:04.1 PCI bridge [0604]:=0A=
=A0 =A0 =A0 Advanced Micro Devices, Inc. [AMD]=0A=
=A0 =A0 =A0 Family 19h USB4/Thunderbolt PCIe tunnel [1022:14ef]=0A=
=0A=
=A0 =A0 09:00.0 PCI bridge [0604]:=0A=
=A0 =A0 =A0 Intel Corporation JHL9480 Thunderbolt 5 80/120G Bridge=0A=
=A0 =A0 =A0 [Barlow Ridge Hub 80G 2023] [8086:5786] (rev 84)=0A=
=0A=
=A0 =A0 0a:00.0 / 0a:01.0 / 0a:02.0 / 0a:03.0 / 0a:04.0:=0A=
=A0 =A0 =A0 Intel JHL9480 Thunderbolt 5 bridges [8086:5786]=0A=
=0A=
=A0 =A0 0c:00.0 USB controller [0c03]:=0A=
=A0 =A0 =A0 Intel Corporation JHL9480 Thunderbolt 5 80/120G USB Controller=
=0A=
=A0 =A0 =A0 [8086:5787]=0A=
=0A=
The working PCI tree is:=0A=
=0A=
=A0 =A0 0000:00:04.1=0A=
=A0 =A0 =A0 -> 0000:09:00.0=0A=
=A0 =A0 =A0 =A0 =A0-> 0000:0a:01.0=0A=
=A0 =A0 =A0 =A0 =A0 =A0 -> 0000:0c:00.0=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> downstream USB buses/devices=0A=
=0A=
Arch Linux reproduction=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
I booted the official Arch Linux Live ISO with the dock attached.=0A=
=0A=
Before running lspci or any hardware inventory tool, I observed:=0A=
=0A=
=A0 =A0 # cat /sys/bus/pci/devices/0000:00:04.1/power/control=0A=
=A0 =A0 auto=0A=
=0A=
=A0 =A0 # cat /sys/bus/pci/devices/0000:00:04.1/power/runtime_status=0A=
=A0 =A0 suspended=0A=
=0A=
=A0 =A0 # test -e /sys/bus/pci/devices/0000:09:00.0 &&=0A=
=A0 =A0 =A0 echo present || echo missing=0A=
=A0 =A0 missing=0A=
=0A=
I captured journalctl -k -b and dmesg at this point.=0A=
=0A=
The failure-state boot log contains:=0A=
=0A=
=A0 =A0 pci 0000:00:04.1: [1022:14ef] type 01 class 0x060400 PCIe Root Port=
=0A=
=A0 =A0 pci 0000:00:04.1: PCI bridge to [bus 09-68]=0A=
=0A=
and the Thunderbolt subsystem detects the dock:=0A=
=0A=
=A0 =A0 thunderbolt 0-2: new device found, vendor=3D0x1b device=3D0x11=0A=
=A0 =A0 thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock=0A=
=0A=
However, the failure-state log contains no 0000:09:00.0 PCI device.=0A=
=0A=
The ACPI/USB4 log also says:=0A=
=0A=
=A0 =A0 ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+=0A=
=A0 =A0 ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+=0A=
=0A=
I then ran only:=0A=
=0A=
=A0 =A0 echo on > /sys/bus/pci/devices/0000:00:04.1/power/control=0A=
=0A=
After a few seconds:=0A=
=0A=
=A0 =A0 # cat /sys/bus/pci/devices/0000:00:04.1/power/runtime_status=0A=
=A0 =A0 active=0A=
=0A=
=A0 =A0 # test -e /sys/bus/pci/devices/0000:09:00.0 &&=0A=
=A0 =A0 =A0 echo present || echo missing=0A=
=A0 =A0 present=0A=
=0A=
The dock USB devices and Ethernet adapter recovered at the same time.=0A=
=0A=
Only after this recovery did I run lspci, which showed the JHL9480=0A=
devices listed above.=0A=
=0A=
Other kernels / environments=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
=0A=
The same enumeration problem has also been observed with:=0A=
=0A=
=A0 =A0 linux-cachyos 7.2.3=0A=
=A0 =A0 linux-cachyos 7.2.4=0A=
=A0 =A0 linux-cachyos 7.2.6=0A=
=A0 =A0 linux-cachyos-lts 6.18.x=0A=
=A0 =A0 CachyOS Live USB environment=0A=
=0A=
Because it also reproduces on 6.18.x and I do not have a known=0A=
last-good kernel, I am not marking this as a regression and I do not=0A=
currently have a first-bad commit.=0A=
=0A=
Workarounds and negative tests=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
=0A=
A local udev rule that forces only 0000:00:04.1 active reliably avoids=0A=
the enumeration failure:=0A=
=0A=
=A0 =A0 ACTION=3D=3D"add", SUBSYSTEM=3D=3D"pci", KERNEL=3D=3D"0000:00:04.1"=
, \=0A=
=A0 =A0 TEST=3D=3D"power/control", ATTR{power/control}=3D"on"=0A=
=0A=
The global kernel option:=0A=
=0A=
=A0 =A0 pcie_port_pm=3Doff=0A=
=0A=
also prevents the enumeration failure, but is undesirable as a=0A=
permanent workaround because it disables PCIe port PM globally.=0A=
=0A=
Forcing already-enumerated xHCI controllers to power/control=3Don did=0A=
not fix the issue.=0A=
=0A=
An ASUS EC/hard reset did not fix the issue.=0A=
=0A=
Additional shutdown/display observation=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
This is not the primary subject of the report, but the same setup also=0A=
has intermittent display and late shutdown/reboot problems.=0A=
=0A=
On Arch stock 7.2.2-arch1-1 I reproduced a late reboot hang after=0A=
systemd had already reached System Reboot. The console eventually=0A=
showed:=0A=
=0A=
=A0 =A0 INFO: task shutdown:1 blocked for more than 122 seconds.=0A=
=A0 =A0 Not tainted 7.2.2-arch1-1 #1=0A=
=0A=
Immediately before that there were repeated USB U1 transition failures=0A=
for a downstream USB device. Powering off the dock after the shutdown=0A=
was already stuck did not make the reboot continue.=0A=
=0A=
The Arch boot log also contains:=0A=
=0A=
=A0 =A0 thunderbolt 0000:6b:00.6: 0: failed to allocate DP resource for por=
t 7=0A=
=0A=
I mention this only as potentially related context; I don't think=A0=0A=
that the shutdown/display symptoms and the deterministic PCIe=0A=
enumeration failure have the same root cause.=0A=
=0A=
I have full failure-state dmesg and journalctl logs from the Arch Live=0A=
test, captured before waking 0000:00:04.1, and can provide them on=0A=
request.=0A=
=0A=
CachyOS tracking issue: https://github.com/CachyOS/linux-cachyos/issues/105=
7=0A=
=0A=
Thanks.=0A=
