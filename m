Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012046.outbound.protection.outlook.com [52.103.32.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0343E7621;
	Sun, 20 Sep 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892109; cv=fail; b=P4bqFuPTO3PJ11vHIB4l86D4nzoY1dav8jxgPRnCYgp+cvp1zJPbpsSONN9KLU5BvzWDrxJNubhzE2u3vBYwSNo9qHMJL+ZeJn0CPCGp0FJ0rjVQRANtniBy08SSGVl2937xsAH2/OG7PR5V6B7Uao1MsNHmcwIBiHZuZu+4W0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892109; c=relaxed/simple;
	bh=f4wSsXU0OUklylT6AD3Si6EngMPtZeMD239ywPidqkE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PJcRe1v7gbbx8OIsgHrh8fz+X0QxKd4dQqtFqxXhrq0oQzSSoGCvuuzu1C0t45kGYBn7sDtyC57ed+5/qaTf68SBGjZIEgmzaWQ2eLYAAHLmzPkH9l/leh35ULwGwmqA3PGB33ArkP8ycx0+/wyDnX+T6OHCriQTzB8mNZkIEF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fl0T3BTS; arc=fail smtp.client-ip=52.103.32.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fl0T3BTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxwOgKHTddZ0/edEWpTrknO58DZV5D7eDJ0bW06s5xWWFm8eEBA5H8mMqKa6+2hPsvVKkgpeIWev+21CDzQMP5VrSpuqT2AbtJhBoOFUlFaGDssA+bKmXZko640g+HhCmEok+1RQEukj0MC2OANbF8xrNl255W9ac5/VMoNvD+DEvLzFUwitc5QetKpqL+oLoEavdE24lDccBjQvI4sg2ETFg660OT3riUgFzVxZTaWn7KYG14IeXPp/Ar3NZvuRQc46YD9PHtiti3kJ8ez8qWJ4m2XkO/1DFSu5u0E7NXHd9dnvXHpLKreJyMX0mjfQiyyLFsLBrugZ8U6gCEJjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzk30utEkSc7XcwgJ8NnBDjlkvn55QEuugFxws6lc9k=;
 b=p57E6W3CdU1YF1iIva51JfIxAJ7Ew3LhrUcNa7hqHXeRZxHlO3arE8B4uB/YGdUmCJRk1IeEvkAZUGfV1nDd5BoWvOLXm8ZxXRhWW5uByFzFk/oeSO7FFh5mTisRduY5Jc7iqXyCxZtzqEUF09R8qdVIL0gg34od0BtqD0Codd1q675FUx5E7ugNtRngZ3T7Vpq+Jc0ssKOGeD784uvrFDkxpjfA/NJOsp++kddYj2UnwhbEbtDbnNgQcR07thSBMg1mQ+w0lAHjcmddH5hnZbfv1u3Sd/SGkn1q39JmMpz3wW7059pPYvwEi7w0VXM322u3qti0zsxueCfFVT8EWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzk30utEkSc7XcwgJ8NnBDjlkvn55QEuugFxws6lc9k=;
 b=fl0T3BTS7fbMADnkKZHIXwDTd5swtCghGFsE+j3R2ocyQ4mhAM6WV6xG8BStGavO5Lymq5r5wz+trmU+d06xWECq420pfwvT7gpV7Spa3du5HpMuTo2NCf9a3jTQihWJno6LPjFc9srYYpspDqVdqtI/kshrhYukoFj/ByAb6nVshMnJFv5YhgqWQUtbW4wj6c2KfcqVtEmF1KVmJx1gs5cdq/RsPKD43/jRMuM79lNs8j8essMPYkRo7TaNBC+IeWt+ip6QXULP4D9mvyHfCHO3suEi/KuhcZQO5w7ERaFJwNbbLppO8oooJX68d2be5ivFPHpLWF6Q/JUEbaEtSg==
Received: from AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::19)
 by DB8PR10MB3691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 08:15:05 +0000
Received: from AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3bad:f430:c3bd:468f]) by AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3bad:f430:c3bd:468f%4]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 08:15:05 +0000
From: blaat windows <blaaaat@hotmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
Thread-Topic: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
Thread-Index: AQHdSNgFTVesDNcghEyLTlxUKUUGPQ==
Date: Sun, 20 Sep 2026 08:15:05 +0000
Message-ID:
 <AS2PR10MB7429335B6C8F4C7FA3F88638B5852@AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7429:EE_|DB8PR10MB3691:EE_
x-ms-office365-filtering-correlation-id: 6faf03d1-0c97-43e4-74a0-08df16ef46e4
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|5040399003|51005399006|24021099003|15080799012|15030799006|40105399003|2607281247196008|3430499035|102099032|4295299021|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?atzmu/ewddl7vMDesr+MSvHdjgfreenha35n/quCTeqzoftWQyRA4dwx4s?=
 =?iso-8859-1?Q?MwkBC/AUKzJplC+LCsgTX1KDmZ7RV1umeIdJQ1EOTfa8dmwqAiBbC6DnGz?=
 =?iso-8859-1?Q?csotBl4AyQUVOi7OYQgzwpwA4tVptI8wVIS8woOfOh4Xg6Bq710AiS592Q?=
 =?iso-8859-1?Q?0xzQQ/0OOeuvcX476LB95zTwI+7Qgs0rMBReMi0bDCZWh5jg8ZCCxWYTXV?=
 =?iso-8859-1?Q?j1bAf56xNWG7h6CNcEnodiKaGwLKr6B+3S8MCk8yXg7ZRp9eSR1UcXak76?=
 =?iso-8859-1?Q?GeHiMoL3gzdxoRamBDpH93Hg6O39bJGohd4sCj6hEaE6y0FkM6aps+wyNO?=
 =?iso-8859-1?Q?21PGZPsn22DYGzY7/CU2ZgqFDo5AnRkvipurN6qEedpXauaNYiDvNdufl/?=
 =?iso-8859-1?Q?41tQ950yNI0H6nBtS3dQwm5GJId7mW7h9sT1A1lMKcz8/hP1cfgUdU3YX4?=
 =?iso-8859-1?Q?9ZbnvsM2hMUsVn6RT1Q+dngtv2d6+7LVuYbelLUfDXE/Cm66wGu7chx7Sa?=
 =?iso-8859-1?Q?rIDXDVa+5K/Ga84NyhzW9o0nnjupXAM/Il5bsS9qT0NLaqkM722WdFBUcH?=
 =?iso-8859-1?Q?y9MUl3GfSPX/khq8/0hDIW26U6YoEaoSFfovEh7ezX1o/073djB4lJO60D?=
 =?iso-8859-1?Q?KgA4UOpJrKVCYi83HM+BlqThB0FhEUETRItmqcrkAXH+WbAUlctNOJgezS?=
 =?iso-8859-1?Q?+dq8z40uwmET6q5NuvDDOLTx+jrTRJsU0hwtPdKhX3BP/lEgwPp39vzkrv?=
 =?iso-8859-1?Q?40Znhu0E/pfBw3mZOvcvSpZNQvm+6hru2GoN3U9MSY9u04qiq35ZL+36zm?=
 =?iso-8859-1?Q?PxqaS6IGcGb5IYk/yFfu0ToKMJuSS59TURZ/kUj7C7hUwjF/8V86kUcM4Z?=
 =?iso-8859-1?Q?zkJME8r2b2Iik/7vT4dUqA8Nbw41e9a8Y1mmamT9PiTttLF15HinplVptb?=
 =?iso-8859-1?Q?LEfkmPXIjqvVQ9QL4APR+VZ4AGVmVhMdrQsr4a91+skp2XpsGp7D6PUU3o?=
 =?iso-8859-1?Q?kEphgDcatupl7w2hE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BEXd6bJ/fzZowSdsKtoo+ZNmPltP77Vjok9vu/o8rIfvcCuq1E2aH2MPzV?=
 =?iso-8859-1?Q?EMikYgET7s0yqhJlhSPzHwALXpuo7Nw6PyZOQRjTDUXrtcYQKoo4UWFYVi?=
 =?iso-8859-1?Q?8A6pcDn4iwZZrYRwjOXsV4hs9moOEq90I7GVhmkGR932eMuNnUL4UaLz/9?=
 =?iso-8859-1?Q?bpWQBQ4xsyAnIPiVZiwCMD+PkYZOWe5Zue+m55tTjrlQ/NNuJdbUKk4iKN?=
 =?iso-8859-1?Q?OyXP2xejWksvzi5TCIQKNwyizkf5Ree0tA/R1NYoG+PaUDZFRSjaIMffc5?=
 =?iso-8859-1?Q?fMPmupkAi6ylCQLRM5bF0g9D8iNvxfx9OrWDAYckoQzWJvw/u2U23tjTmG?=
 =?iso-8859-1?Q?0DGH0oNP9ZUFS7UXeLkd3WTyPhJUcV9Rwmg3XXkS0Fo8VsHu/8NJwXrt6G?=
 =?iso-8859-1?Q?vhodgaAIIPwIWxDopJqpXSdbNIc4Tr3T6GU/KerkVmxRH5ixZE3aTEufi4?=
 =?iso-8859-1?Q?s8/B9TtP/TwLjYh8FvZ67GP84rrCHdzRfjc9qfmfiuGnu2iPc1RLAzlI2t?=
 =?iso-8859-1?Q?yMw41mF1e4WtsTOkY0jDjMj+hJfSvnhnevztn5FVw5h89XKlRJhuHN8+N5?=
 =?iso-8859-1?Q?PjoPkWcCyorDB8Ow1164NHkOfVzbH3y01dokeCIHHv656vt2FLQeTc5aij?=
 =?iso-8859-1?Q?bSqLc3uNUohLXhhkwe2htvyR+pVZhFgTYGZDmpSMTIZydnIho/mldCvUX2?=
 =?iso-8859-1?Q?cwVtatgVOhPVZ1FEhkrwdT0AwEroMyHoMBnVrKomT+JKF6XFsBOViFr2vE?=
 =?iso-8859-1?Q?rntuKFBp5e9hh4Jbu1YpWq4A35fhsjJvkXYlx3sJsy5UmJzgSFg2x6S4Q+?=
 =?iso-8859-1?Q?Ab8T04n9bHz2+B7ehNg59i3S0WEL7rImIkiAuQRcopssL7ERLuSteSYpEB?=
 =?iso-8859-1?Q?RQqkX9HhygFR04WxiI12aY5vs0+abIaTf5XVyAPO2NsHSzh+t0jnDCmwVu?=
 =?iso-8859-1?Q?SZzIHjz4AzlYx8LqFXPHaqippyjOqtP6X/EQYBdr4vSCYIaEn7BHlXjW3F?=
 =?iso-8859-1?Q?98D8p2AXxsRD5zrmTlmG5+ORDDPYmuluZKS/onwjuSAyUDQ09hogolKNhO?=
 =?iso-8859-1?Q?FXo0IcMh6W83wsvHJBFqutdQQtvAUNiv5NVngBpY+fNlz+6pkK3qYITn1A?=
 =?iso-8859-1?Q?s93Uja+UZDQe8gIvWzNkwQIqYcY5rPJu+WfisjDKVP9/rLXRU3CnDPNV1T?=
 =?iso-8859-1?Q?yc04e9hTJEZgmQdac3EXCwPVVSConnRvsCS+10dnVF++aQheMjVzOfQqJ0?=
 =?iso-8859-1?Q?L5La1k+1zEZLw6JvUYcO7qRbLJodoCiC0i7qDO1yPNjXDlRzr7v5i9Grvr?=
 =?iso-8859-1?Q?zk66jHouRsUSFVR15SsVb7Iq2QR6SuQUHcum296Wal/o+KAaN8MlYIyBFf?=
 =?iso-8859-1?Q?fveNFhRpACqoWDlu1TkM4oQb8jguW019sGSaF0us6mgumxJfoPZJo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-d3deb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faf03d1-0c97-43e4-74a0-08df16ef46e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 08:15:05.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3691

Another reproducible case of the active-link failure described in this thre=
ad.=0A=
=0A=
Hardware:=0A=
Intel 4th-gen/9-series platform=0A=
Intel 82571EB quad-port NIC=0A=
Microsemi/PMC/IDT PES12N3A PCIe switch=0A=
Root port 00:1c.4, LnkCap 5GT/s x4=0A=
Working negotiated link: 2.5GT/s x4=0A=
=0A=
Kernel results:=0A=
7.2-rc1 fail=0A=
7.1-rc7 succes=0A=
=0A=
On failing kernels, the PES12N3A hierarchy does not enumerate and all four =
downstream 82571EB ports disappear.=0A=
=0A=
I traced this to pcie_failed_link_retrain() and specifically the new generi=
c clamp-removal code introduced by 72780f7964684939d7d2f69c348876213b184484=
 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining").=
=0A=
=0A=
I tested 7.3.0-rc3+ with only this block commented out:=0A=
=0A=
    pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);=0A=
    if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT) {=
=0A=
            pci_info(dev, "removing 2.5GT/s downstream link speed restricti=
on\n");=0A=
            ret =3D pcie_set_target_speed(dev, speed_cap, false);=0A=
            if (ret)=0A=
                    goto err;=0A=
    }=0A=
=0A=
With that block disabled, 7.3.0-rc3+ boots normally, having all four NIC po=
rts enumerate:=0A=
=0A=
07:00.0 82571EB=0A=
07:00.1 82571EB=0A=
08:00.0 82571EB=0A=
08:00.1 82571EB=0A=
=0A=
The important result is that the initial 2.5GT/s recovery is fine. Leaving =
the link at 2.5GT/s works. It is the subsequent:=0A=
=0A=
    pcie_set_target_speed(dev, speed_cap, false);=0A=
=0A=
which breaks this PES12N3A/82571EB link.=0A=
=0A=
So this appears to be the same active-link failure mode, but with a PES12N3=
A switch rather than a direct 82571EB connection.=0A=
=0A=
This was tested against vanilla 7.3.0-rc3+ with only the above local change=
.=0A=
=0A=
I can provide full dmesg/lspci output and test a proposed fix if useful.=
