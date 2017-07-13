Return-Path: <SRS0=kNUL=6Q=chelsio.com=leedom@kernel.org>
Return-Path: <SRS0=kNUL=6Q=chelsio.com=leedom@kernel.org>
From: Casey Leedom <leedom@chelsio.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Ding Tianhong
	<dingtianhong@huawei.com>
CC: Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Michael Werner <werner@chelsio.com>,
	Ganesh GR <ganeshgr@chelsio.com>, Asit K Mallick <asit.k.mallick@intel.com>,
	Patrick J Cramer <patrick.j.cramer@intel.com>, Suravee Suthikulpanit
	<Suravee.Suthikulpanit@amd.com>, Bob Shaw <Bob.Shaw@amd.com>, h
	<l.stach@pengutronix.de>, Amir Ancel <amira@mellanox.com>, Gabriele Paoloni
	<gabriele.paoloni@huawei.com>, David Laight <David.Laight@aculab.com>, "Jeff
 Kirsher" <jeffrey.t.kirsher@intel.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, David Miller
	<davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Netdev <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LinuxArm
	<linuxarm@huawei.com>
Subject: Re: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
Date: Thu, 13 Jul 2017 18:44:41 +0000
Message-ID: <MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>,<CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
In-Reply-To: <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0MWHPR12MB1600namp_"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--_000_MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0MWHPR12MB1600namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

  Yeah, I think this works for now.  We'll stumble over what to do when we =
want to mix upstream TLPs without Relaxed Ordering Attributes directed at p=
roblematic Root Complexes, and Peer-to-Peer TLPs with Relaxed Ordering Attr=
ibutes ... or vice versa depending on which target PCIe Device has issues w=
ith Relaxed Ordering.


  Thanks for all the work!


Casey


--_000_MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0MWHPR12MB1600namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;=
Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Seg=
oe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols;" dir=3D"ltr">
<p>&nbsp; Yeah, I think this works for now.&nbsp; We'll stumble over what t=
o do when we want to mix upstream TLPs without Relaxed Ordering Attributes =
directed at problematic Root Complexes, and Peer-to-Peer TLPs with Relaxed =
Ordering Attributes ... or vice versa depending
 on which target PCIe Device has issues with Relaxed Ordering.</p>
<p><br>
</p>
<p>&nbsp; Thanks for all the work!</p>
<p><br>
</p>
<p>Casey</p>
<br>
</div>
</body>
</html>

--_000_MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0MWHPR12MB1600namp_--
