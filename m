Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49839B94F;
	Mon, 16 Mar 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669611; cv=fail; b=nb0sDkZgOSkBUBEd1RUF39uLFA9cAntn4eukzZ/rPiOGULeB6DBphuFpsX6AK+sFQxm++whf1EdxKKTGXLE5V1DfB/Hoy7Ll2GvlT48m6PE+NaJhCkNJ3KYGXhTJADADmuZm9iE+HAwUATSgAlScdtKKGGEJD9jw90J7lyQmfXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669611; c=relaxed/simple;
	bh=n2D9vKNJqNtyBxvRn2GGQDCPiFIk9kcGjxt0tgng/9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i66dBqB4CESIkBsq7PbPfr1aK03HcWSM1aTMDZKpbbyaqwgegzyDUFfJPdANfyc27xe7n1EKQN6+0YeiymvM0rRqbmmuPcSeFGvEhTxCPw9Zsjiv+DRuTXrJic5x7dyBHGpMZjVuBez0snQOHlGiQdcacbj6wePyFCdwFajikB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhVkDYxX; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhVkDYxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyZKcjZXLeJ8UbEGBDCZww/9MVitDGxKhsb4ou8dUboNBw4AzOk3ut0EZ90PXH1fjQ0b/p1MI56nREa5B3cBpbAV3IqLuzkfA440YP+EVWM3KYAnhqZMlj4KU7c6Nmcxl4Mvuv0IB9PR0Y5xeVnWbLl5MYGXOJ7mQZqPyJzXhYjTGsJXU5WgWWtfNuGUEfk/oDdJH2QEGK7+C5NRGWkmYhCYiVfM8oEXSAA1qhbTJOdOrmpqFmAurWNxzQtFuuM1kUzypyyk1n4UjWIwFJ6cL91Tf9yBTn81nIF8PdDr+BLeLx0lQSUA7NbEcgpyCR6jHHHsfJpCd1RallfnMXtcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rqM9po0Ke58a4+G7eFJfFy0U5pze+Sl4m3kyyOTmJ0=;
 b=Kc/kh9IEbvihCYPZdCd0CO09VGntvjIXLfHJITmI7iF7DyNb7tRW/oJu0fgjp7P/NCAXy6UVniHkfGQAxNr3MhcF1v2OeT16YDQk3hd76VWbdcvX5fPQdxTYUC+8kIFlZfrf10ZirzAu13ac703wZBbuAQvanb/6HB5sdA+LL8zcrAuN412l6oX4ozSgfofTbmHZQ4M8mpU0F+8S6CmIOBGL9zwOIizCUWudKFl+XlPQrh+/A3KLeIYakm2DcWYHXvVmUEYghLLdif7K88chEM/ghRdI88oyvknPo1NugCVBWHlFT1EU+AYBdS1Rm3QQsg5mTgwzrKDgt8a3FgVLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rqM9po0Ke58a4+G7eFJfFy0U5pze+Sl4m3kyyOTmJ0=;
 b=qhVkDYxXf00bWYFNBAQjGc7VUwn3BpsQKc9h5ZJb7biJkTlUbdSI4ep4AWjd9O2ebqkCfi0rkMqwX9x3uPBN86Ft9LYjmL+IylckwyrSawWHeQ0kfgWDInKaSbcLGeJ4rg0vU4hWBfdhmZAh/9tzAP6mDO/HRXRKU9tXkJd5WO1crB/e9cJg0YXHwlW/scy3Bz10p4ts9VJK0g1fAV2MjTpFCYQEdaXVatpsKVoV4j6HivhVTh9jzXkKk5G10w8LltFH2JYRaZmKDV+GANXY1oXOT7njCSvLkqcBCD/IQgLpnEqlI4H9VE6CD56IxR2/wf4+FW8Lh3G99EEVe3Daog==
Received: from SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 13:59:59 +0000
Received: from SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b]) by SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 13:59:59 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Srirangan Madhavan
	<smadhavan@nvidia.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>, Alex
 Williamson <alwilliamson@nvidia.com>, Jeshua Smith <jeshuas@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Manish
 Honap <mhonap@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Thread-Topic: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Thread-Index: AQHcrT9YMN+ro1mip0CjGkOyIzNHCLWq3pmAgAZdM+8=
Date: Mon, 16 Mar 2026 13:59:59 +0000
Message-ID:
 <SA3PR12MB9131917FA823F0F659BEBDB6BB40A@SA3PR12MB9131.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <20260312123419.00003aca@huawei.com>
In-Reply-To: <20260312123419.00003aca@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB9131:EE_|DM4PR12MB6278:EE_
x-ms-office365-filtering-correlation-id: fb5a1804-dc4e-4f0c-1eb9-08de83644fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 8ajOlDPRkMLRieFa0c92Nlf1AeITaqkhXr5s4HPB/u1ufm6jYMgCrhNURF6Lq+UPtdljPRiO49bhfpzVnSBX8KXHfqGYbvURNXpkPNkFxoiyrDL28o9UZsQm6Xbp7BZ6ibppnOu35ZRV7328u0FNDTo4CMDlYlge8E4BWC+5hm67i9ZGiIGcRkwA2qovKP3jX3HPJvlvyvGs/me+AI2cUX69+1BqxRt/h2JExXMLK9rzcv+9uOWA0qV/V3P+dK6fmZRfYxzufG6Wl07M4JMW4yMhk126jhNVRcUdXUHV7LNDbBulu4WB7iIu5MxxePwsh5vCfNPZuPP3eQzpX286RbzYzqV3heRNM36ywbH04Q2+9rzXcZ3WhmKEOhd+6yKc9Uj8P3efOIUfoI4cP2U2tB6hPlwxG9SEjTwKhSaBTltNp3cvwSrjeF0x+nRT/lGN7rImd7b4elbEqvYOkE9yaaAb6jKgihxuwyDDnz0Wv/n4e71c6Ms5o5+afVtJAdHnWyew2kKdiMxowBNvHYbKVUnqiA4bntDC03j0kKpBWzrGJZVE1fQNWPVlcE+33oHhOxEb+uzJ3vtPt8MjQFoCcR6rDRwq/mU3WT0/ZYLuARfQMpYgzIAjZjns+Z5sRlbFUdREEk+v8cJ6Yz6JHSOUYDnw9GGIrZX9/5mQN4LMUKZguFcIrtJce8zjjb9/0IT4E6ugiKpFZtsJEh+gZ3zfWdrPUbpzNxah8uqHNY2oQFNC+ieuc7GYkPMMJ1MH/qVbkdmZJ9yjKSAfky1zuWfKWkYYZHRutM1k6356MoAAv4o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?jXZsPm81ZAC1fZP8yaj5YWIzAjXSt1VlFyYtcaNaQvjTFL5vNMwkvm7A?=
 =?Windows-1252?Q?ACC4wAOQEmZYuCyVeLljX+QvgaHbMMfvepw0ZGonH6BqcPVGMOoYFQww?=
 =?Windows-1252?Q?mKFikBGuourdv+K/p6KtT0Ee+8m185RxJmUM5VkqClBIG8Hcdsxf8gkg?=
 =?Windows-1252?Q?tq16hGEGUIg3m3MlXPJg6K1OLd/Gq7heUn8uSBgU+JkDZ1JJKYxhTLG1?=
 =?Windows-1252?Q?X48v9LyEGTyE9ShuOlKhMOHYV/9NISGzIQZCbCN5hAJFiO17+1X9QhIX?=
 =?Windows-1252?Q?VuRMkCAr/JHk/79iUSNa6N6ol+x+vSxUSIouGADfLgSZnE7BxA6WuS0T?=
 =?Windows-1252?Q?MSamGSFCCb8LjCEWtj2l75z6tTQAAWWu/zTuHdm/14Y65mZ1M7/t0MNw?=
 =?Windows-1252?Q?cHZE4yXg7BB3VaG7HxotJJ4JWlv1uUec7b3okdLp6/o6fiCSukFbcTo4?=
 =?Windows-1252?Q?Rr75cXQ1I0Oyay8wEB4nWJSnJclA/k82Vv1lA49bkH8QfX5mc9nZvn7m?=
 =?Windows-1252?Q?Xj+Cv2fnxrIkiIG/K6esfMCJphGsLdnwb4H+YkL73GXbYiJH3MPo9Ayn?=
 =?Windows-1252?Q?iTa1HAwHiT38EnJRRTdThmFWrKPVkbfgGlftQ6NA6KE6JYtUDQAocFmh?=
 =?Windows-1252?Q?ccMfDH/d4ke4DvSXv5/XrpIZegAPPfVm5oEESDm2H2yna0oL4RO3AfU+?=
 =?Windows-1252?Q?xwafucmnuNhpR/TynMEKvYS3/8G/O9mcyqUJuRlk77jaw7TURlqGN/bl?=
 =?Windows-1252?Q?b/gZi4gCY6rIQ12GPb54b6hDqVKBkg1E7jDQD34Zk4+ZotfpHZMHMHBl?=
 =?Windows-1252?Q?N4m2OF6bhIBv35H944UUG0sNhOaD1gq75GIzxUXwFhGZUWuRm0oGuUZe?=
 =?Windows-1252?Q?6DxuVdy09GNmiYGQfuUQM+yCQnT/7Jus+oPilJpBuYElmPdLFEYCHYV2?=
 =?Windows-1252?Q?G3aDmdGxyjH7aFbaaECNWJyZdqhuHPsOS8QyKwMlB8XJcte4nk0C2ISR?=
 =?Windows-1252?Q?FInCVHeUOOjSCfa/vGfQBatZ4jfnLAW+xGEIQB9JvTXxqShndsHwB0Ej?=
 =?Windows-1252?Q?gxrCqCxXMXOELZS3WAiHFhBom3xHqvpxaDkThLbQkVb1xxV3DMArSoWL?=
 =?Windows-1252?Q?wLvrimkw8o3xQHcvU8hTI+t6FSgJfTW/cPZh+KHHxYss12mb3/goPcHO?=
 =?Windows-1252?Q?BDjfe5HFY48QBCQrohF45sZkRfd71BD1g1g50G4lK2XbXVa1M9unfWPK?=
 =?Windows-1252?Q?CD/8UAXfswGFFdaXJSGV6lR0jDO/xulG1ahaxdVfcFjAoFLLmLMxGvny?=
 =?Windows-1252?Q?cRiJAUS3eJTr/iXrNExpXa30raQ81bHwxK7kn0j+UJfvvGosV9emCeeq?=
 =?Windows-1252?Q?31mS76qTSXvTQsyOE+t7DV/vQ+rZAvS3M3BSmQPU0WaR7Qg6yVBad6n5?=
 =?Windows-1252?Q?iuNWPZQWzed2Ua2Ud0jWC4m2LRfKNWPF7+T+zEMsQZO5x44e58xBVpqk?=
 =?Windows-1252?Q?AbMKSZbuLQuONHg5z3Dy5I2cyd/D5xnud83R75fPsWbvRm/p0mEYjvnV?=
 =?Windows-1252?Q?PdZ5OBs+o4u/e/36W4uIJB7qqGoVxuKeDSyc0tQt2wwtx4Qmchmu0B+c?=
 =?Windows-1252?Q?iwN2FtivA8QtxraQAdY/TYHnQ/uqFNGtiBt0IpzikaiX+AnvbPTBNFEY?=
 =?Windows-1252?Q?QJkekyH94GeyAOxSH4UUyezcCJWSjf9uV+TWLiXsp8JdTmnmDSOp2kKs?=
 =?Windows-1252?Q?rkBirjvmmxhISTW9AjwODggN025kOahQZ8I0b1f2gOQwqvLYyTF5Q1RC?=
 =?Windows-1252?Q?E8cyIt41ovnGxOAoo9Ivsewd12XGMnaDu9ydVc+LDZIlBiuw?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5a1804-dc4e-4f0c-1eb9-08de83644fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 13:59:59.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACFg3Zixc3iKpmEXfkQEJ/EdtTuq6Z7PT3QIcrliYFNwBUNZsD3v6YU9BLz7EoLy+MBCJF8I/kV9CUQ68PebXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278

Hi Jonathan,=0A=
          Replying on behalf of Srirangan. Srirangan, feel free to add to t=
his.=0A=
          =0A=
>  In general I think=0A=
we have a problem if a driver is relying on the bios having set up the=0A=
decoders and simply doesn't function if the bios didn't do it (and=0A=
that applies in this reset case as well).=0A=
=0A=
The issue for us (and possibly for other devices as well) is that it is pos=
sible to reset a device without the device driver being loaded at all. One =
usecase is in-band fw update followed by reset to cause the device to go th=
rough its own secure boot. Now, arguably the device driver can restore DVSE=
C + HDM decoder + whatever else once it loads. If the driver is not loaded,=
 it is not possible to use the device anyway. The main thing here is that w=
ithout the driver present, reset_prep() and reset_done() cannot be handled,=
 so we wanted this to be restored by the kernel itself.=0A=
=0A=
There is a virtualization as well as confidential computing angle here as w=
ell but I am not fully versed in that path to comment.=0A=
=0A=
> I'm thinking the reset flow is a good deal more complex than simply=0A=
putting the bios programmed values back.  In some cases that might=0A=
be a very bad idea as autonomous traffic can hit the type 2 device=0A=
the moment these decoders are enabled and I'm guessing that may be=0A=
before the device has fully recovered. =0A=
=0A=
Yes, completely agree. In fact for our GPUs it's a combinatin of kernel-fir=
st and firmware-first. But we, at least, for our use-case ensure that the d=
evice will not be used before reset is completed by means outside of the OS=
 control.=0A=
=0A=
> Note it would be good to document what is restored ....more clearly=0A=
I agree. Srirangan, could you please list out the DVSECs and capabilities t=
hat you are saving and restoring? =0A=
In general, we should be saving and restoring anything that was locked but =
possibly got unlocked or was set back to its reset value. Things like mem.e=
nable, cache.enable in DVSEC 0, range registers, HDM decoders would be at l=
east unlocked if no wiped out, etc.=0A=
=A0=0A=
________________________________________=0A=
From: Jonathan Cameron <jonathan.cameron@huawei.com>=0A=
Sent: Thursday, March 12, 2026 7:34 AM=0A=
To: Srirangan Madhavan=0A=
Cc: bhelgaas@google.com; dan.j.williams@intel.com; dave.jiang@intel.com; ir=
a.weiny@intel.com; vishal.l.verma@intel.com; alison.schofield@intel.com; da=
ve@stgolabs.net; Alex Williamson; Jeshua Smith; Vikram Sethi; Sai Yashwanth=
 Reddy Kancherla; Vishal Aslot; Shanker Donthineni; Manish Honap; Vidya Sag=
ar; Jiandi An; Matt Ochs; Derek Schumacher; linux-cxl@vger.kernel.org; linu=
x-pci@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state =
across resets=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
On Fri, 6 Mar 2026 08:00:14 +0000=0A=
smadhavan@nvidia.com wrote:=0A=
=0A=
> From: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
>=0A=
> CXL devices could lose their DVSEC configuration and HDM decoder programm=
ing=0A=
> after multiple reset methods (whenever link disable/enable). This means a=
=0A=
> device that was fully configured =97 with DVSEC control/range registers s=
et=0A=
> and HDM decoders committed =97 loses that state after reset. In cases whe=
re=0A=
> these are programmed by firmware, downstream drivers are unable to re-ini=
tialize=0A=
> the device because CXL memory ranges are no longer mapped.=0A=
=0A=
Hi Srirangan,=0A=
=0A=
Firstly this might be because I'm behind on patch review and there is=0A=
a lot going on right now!  So this might be addressed in a different series=
.=0A=
=0A=
I'd like to understand the whole use case + flow here.  In general I think=
=0A=
we have a problem if a driver is relying on the bios having set up the=0A=
decoders and simply doesn't function if the bios didn't do it (and=0A=
that applies in this reset case as well). For starters, no hotplug.=0A=
Anyhow, that's a different issue, so we can leave that for now.=0A=
=0A=
I'm thinking the reset flow is a good deal more complex than simply=0A=
putting the bios programmed values back.  In some cases that might=0A=
be a very bad idea as autonomous traffic can hit the type 2 device=0A=
the moment these decoders are enabled and I'm guessing that may be=0A=
before the device has fully recovered. There are very few spec rules=0A=
about this that I can recall. On the setup path the BIOS presumably=0A=
got the device into a state where enabling such traffic was fine=0A=
and hopefully the driver bind doesn't break that state.=0A=
=0A=
I think you are restoring CXL.mem as well so that gate isn't=0A=
going to save us.  Note it would be good to document what is restored and=
=0A=
why more clearly.  Sure we can figure it out from the code, but=0A=
a document might make life easier.=0A=
=0A=
A device might handle this mess for us, but I doubt that this is universal.=
=0A=
For type 3 devices, I'm not sure what we want to do on reset in general.=0A=
=0A=
Anyhow, this is really a request for a more detailed description of the=0A=
expected reset flow that goes into what the spec constrains and what=0A=
it doesn't.  Probably something worthy of going in Documentation.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
>=0A=
> This series adds CXL state save/restore logic to the PCI core so=0A=
> that DVSEC and HDM decoder state is preserved across any PCI reset=0A=
> path that calls pci_save_state() / pci_restore_state(), for a CXL capable=
 device.=0A=
>=0A=
> HDM decoder defines and the cxl_register_map infrastructure are moved fro=
m=0A=
> internal CXL driver headers to a new public include/cxl/pci.h, allowing=
=0A=
> drivers/pci/cxl.c to use them.=0A=
> This layout aligns with Alejandro Lucero's CXL Type-2 device series [1] t=
o=0A=
> minimize conflicts when both land. When he rebases to 7.0-rc2, I can move=
 my=0A=
> changes on top of his.=0A=
>=0A=
> These patches were previously part of the CXL reset series and have been=
=0A=
> split out [2] to allow independent review and merging. Review feedback on=
=0A=
> the save/restore portions from v4 has been addressed.=0A=
>=0A=
> Tested on a CXL Type-2 device. DVSEC and HDM state is correctly saved=0A=
> before reset and restored after, with decoder commit confirmed via the=0A=
> COMMITTED status bit. Type-3 device testing is in progress.=0A=
>=0A=
> This series is based on v7.0-rc1.=0A=
>=0A=
> [1] https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.=
lucero-palau@amd.com/=0A=
> [2] https://lore.kernel.org/linux-cxl/aa8d4f6a-e7bd-4a20-8d34-4376ea314b8=
f@intel.com/T/#m825c6bdd1934022123807e86d235358a63b08dbc=0A=
>=0A=
> Srirangan Madhavan (5):=0A=
>   PCI: Add CXL DVSEC control, lock, and range register definitions=0A=
>   cxl: Move HDM decoder and register map definitions to=0A=
>     include/cxl/pci.h=0A=
>   PCI: Add virtual extended cap save buffer for CXL state=0A=
>   PCI: Add cxl DVSEC state save/restore across resets=0A=
>   PCI/CXL: Add HDM decoder state save/restore=0A=
>=0A=
>  drivers/cxl/cxl.h             | 107 +-------=0A=
>  drivers/cxl/cxlpci.h          |  10 -=0A=
>  drivers/pci/Kconfig           |   4 +=0A=
>  drivers/pci/Makefile          |   1 +=0A=
>  drivers/pci/cxl.c             | 468 ++++++++++++++++++++++++++++++++++=
=0A=
>  drivers/pci/pci.c             |  23 ++=0A=
>  drivers/pci/pci.h             |  18 ++=0A=
>  include/cxl/pci.h             | 129 ++++++++++=0A=
>  include/uapi/linux/pci_regs.h |   6 +=0A=
>  9 files changed, 650 insertions(+), 116 deletions(-)=0A=
>  create mode 100644 drivers/pci/cxl.c=0A=
>  create mode 100644 include/cxl/pci.h=0A=
>=0A=
> base-commit: 6de23f81a5e0=0A=
> --=0A=
> 2.43.0=0A=
>=0A=
>=0A=
=0A=
