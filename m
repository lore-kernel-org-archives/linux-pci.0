Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C04499B3;
	Mon,  7 Sep 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773928; cv=fail; b=cOmHGaX5Bif3iQ1xgCPydgXzxPUeNOxPPkRsHZVO71W4ONjgb2veCi7gDJqAEuP8NBBj/hyqtb8J79+geoSeE5b+ULUhItLWnwNhNQPK1CfjYlOeJHYXPExyTnWCpDqGHyzQTtuReve5IyWejVouuN5NTDoTcPRfyZiT45lBlk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773928; c=relaxed/simple;
	bh=4FEGXEMEvv5Fb7fiLxlNieThMSe8hvmxH4Ze0YHUmOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9f/Ch9mMYJHYBMF8fEsPzkMl67XjlvL8Z3hBGAjc78sofEEcRR2XdkTL/aTpSjMpGD1RtTKdQTWq5QXjX9L3e51NJgpcir1SeiVxVQvbi2WonzvdVTx6HtpbGnT9dcGTIWBjQaKvFE+60joGjwPutU9++dXUZoTiY8oYKrr1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kj5d0Uuu; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kj5d0Uuu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/a3XRRFvH6Ql6wTmGjw3jUXlb7cZmC3wqlhszB12RQ27aMFTiEtGEcTSzkJBXrtHlWsu+luUZ1fZdLpwIGVB0XbfX4jqDfWXCLi0JrN9iSkKErl+el79ND/zPxVnz9RrQSvpszKJL2VZSgeQK5eZvdE6HLAP7rmW2hBGZxnfFrZwZeTclF/JutjmVzyYT4EgC1AJw3sldBOqo5ZkD68znuU+TP+SCPGqOle7+9jLofEAOrF2ffIGNfe3XX/5sOzvhLgtn8pOoHjwxAILaXusgYv5or9fGGteCJQdJzfmC2CsgpCwUtj0V4PBs6NXpx401ULQn/ghTOUW57aLoB7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+waHK1HzIXKla96d6VOvXRkPRSbJm8WkxI2/AceiQ=;
 b=wZU+DP1IHBpq5wBbGoCT/hPF+ykm0Hqyh8e5SmxgLn0ESO6qQWPfLP618hDsWGPJub/80uiuJklN2wlmTVqOh/S9FzZ3OOK5DmsUWiqgYBPjbTTmgi8LtWc1RHREPGjAPyyQzlvZsb5PLhgDhznVxU/lFq62tyk1g55cW/gTf7BhqQTMOF3+Wi6olMr2EskKx247CwVEvgbUYXGzQHKd3VdJK16Z5Ejo2UOK+lxo2TuQppag7kMOlfoHAVLAakpq3N52L3/GVnYYalp/Yn3x3EZ9ZxL4cyD3xHVK/atK4n+2piTgGRQR1ii7aLVu+9qwevKENvkyO3D1qo2W3CWmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+waHK1HzIXKla96d6VOvXRkPRSbJm8WkxI2/AceiQ=;
 b=kj5d0Uuurb1FC0NrO4r/yO9nyD/aPv5+vVg2XYNIFpwyWGlXXpRd5cj/f1snn8gLrH/UQA7y2s24OxK/9hsIGq/MgUflhDugA3imuWWrHGDelcg3g92mmpkIrhzGKuLXjBXx42jHFJKXcQ/9U5Vi2eexcdJ9wn3oJ8IUiBBf93sRcJ4BAWwvL7g/hXK6sm6+xTVIS3dgJZ5dJDHHdLzIzoIOrjN4skAMu/K4hDoLSdcLtg01djrZGqEjxDx6PAaLJ2whSeorjtHW/wTZ3N+vBvMxHhs49Gee0axhVGvS/ufxq2gkktARS+VZQ0lRg3XXs55tNOB6f7I1hKEycjf/Dw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 09:38:41 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:38:41 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
	<kbusch@meta.com>, "michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	"satyanarayana.k.v.p@intel.com" <satyanarayana.k.v.p@intel.com>, Sonang Patel
	<sonangp@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>
Subject: RE: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report
 state to userspace
Thread-Topic: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report
 state to userspace
Thread-Index: AQHdPKDu3EL6GNr7AUKHBFJoVw5VDrbC2cZg
Date: Mon, 7 Sep 2026 09:38:41 +0000
Message-ID:
 <SJ0PR12MB861421F7FA18CA04BFE996FDABB22@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260904130927.2e234a21@shazbot.org>
In-Reply-To: <20260904130927.2e234a21@shazbot.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB6614:EE_
x-ms-office365-filtering-correlation-id: 0bbc4971-77e1-4e97-d6e2-08df0cc3cd51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 CCSSVruG0wqTkOji6zS/7foUqhx6Dr0PNZ4Hi6+n5Rh6TWyi7Sm13pjGZwCbS9w1BrFFTzlLbu1lw9PLGT47IS6FiEz149vwOAaIrDQPPzDBjlOry18mwU4r38WeBfTpquuEga3e/A6jF6E/cSyoMaMed+0o4F2HvQ6nC9rs6VXPpl9AScXtMZvSlooWEXgjFyhSTAr9zmJiNkTZ9AvOYYbs1kCD+VwQFr/XRZVoGtkjEPWLattY4x8Qqh15iIK2JT8z3XWaG+EIujxs+vvOR5zBK4bfrGRARmYUfazKbvGWVqup9bgalILnSU2sxNyjdifXMwCHPAlHc64eVrXuERA76r4fP+pnBzTmq5xPyGJL5CmQWHXhjyx5/wvZ5ucZpVVTOr0mG+9rbyw4PFz9SherS6YtnGPUFh7QIH7E9WVGvWI0/b38m+45flUvOia0A92474tVRS4UXXbG8XbLJB1LFtHM12t/oojlDx5MN8cYldH8D7pvKZggxecyY6l1wnMViRXl279vII5Gf39mGBGgvVuvTFTaTVXEl/IGYh7Vre1BOfhwkuF7GiGYQI1ZKbC+xL1O5MK/nQRvqUZ29zMeE2dbfJaRfVq0oAXLMhncf0BMTXu8DWFxNLXl4jsraxNdvL/t0i+iHLWvlF9L0lQGhxPgQ/cET2LkJt0+ofzrm6xT/FPqstFzkfa2K7w0xggdQ1aCh3R35jzTrUO4draL+l8RcIqWsl3h/viwEMg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+pvW403gCijhtRm1pD5MZ0et+JUnNd3M3SMntx9VB/RKlF/Aq5VYa582dkRa?=
 =?us-ascii?Q?AGfpNfx1713G1XPDIpV8ZYfCV/ZO8Au36WIgNq6ZBDf9AZHeaHcCRsX1yIzl?=
 =?us-ascii?Q?HKIkaxUV4eBi907GejhTBgBjyxzrCgJc7hqtQ5rm9EMU+LJo1FTObOGywi5g?=
 =?us-ascii?Q?+vTopNBpciZKMXAPYZnWc+tj9BAmpfLrycU8+lOBV2IOCGZSh4TMxKnQ95yP?=
 =?us-ascii?Q?uVZUEqg4b7DE3xE1z66QBsFT3hKMLc4DaR8klrwr8TQfhIrvJdX0qqM1FAaB?=
 =?us-ascii?Q?lXMd706d469A7fT035g3W1e47cuiH2Xkl/0biRvwwu4SMlTCiKRfD+zEW31a?=
 =?us-ascii?Q?WIwy1MyMquold6+QFFpOkoexQlUQavcB1gNnwmdSWEzYB8cRpKyJJuM5Nhag?=
 =?us-ascii?Q?GxuT7P/7MeOts3Ic3HvsBTeNxZ88tq1Qop9aC3lRLQLFiNBGrt6dmMFNltXa?=
 =?us-ascii?Q?Ji4BjDAZCPKmlrs0gHg/8nLh+LAAg8SrfODItbxna4UfegN8ZH3QcEcsdk/2?=
 =?us-ascii?Q?DfoNf+Oyd/PbtCutzD3GvikUUx4gfRQsc25pnxkY7mQaQj4D9TYDmZCGEWcT?=
 =?us-ascii?Q?hgpkljFAxvAgFieyiP0wPW8PzGJLs3ANCq1tTc4Eh7uhtjDDmcJlmDAbpGp2?=
 =?us-ascii?Q?fNou5qA2MNyxORfJWkWIjg5FagSw4ZTXPrOP4GEiMihqujWKgCyALFf+cKTx?=
 =?us-ascii?Q?UWkn+l96ltSiTglwBAweoA88qpMRpEKaDGhgdmuE72vGjbHk4ppWLXY636gF?=
 =?us-ascii?Q?++r9QwexIZmq436dyC8HaBrANkwlPll5t5Ty5MzhDVzWjqVT211umwjYNXtx?=
 =?us-ascii?Q?CdlPLBa2Xm1B7GTzzW80zoYbeZ8DohcyBposBpcRkj1NxAovTioItxwq56dt?=
 =?us-ascii?Q?5CnSYL2mVFMcf/sh4yW/s6Osw8jagE0V4x5tfJ0sjXfUnyAJiKBJvs/FjntZ?=
 =?us-ascii?Q?WJruGzvdD5d84H/pSLRDTUS07MJI6dN8t3o93h7Sz8JbXREpMkhpaCUHyDS0?=
 =?us-ascii?Q?DPUZ9l5aPCoK+j0kLkHkP4RBlg5ulMsZBS4xjsYC4lLFXOTF9sQ9K0o5DsyU?=
 =?us-ascii?Q?2aMR2gVrQdqpwkZyzOrl1tITKjtj9Kk+b6rX5z0xWjuXvChETxT/8hU0LSDD?=
 =?us-ascii?Q?ReMd1iLrH94xSImCtyQlyoa4l40lGwLy0pzq1UgXyw6cnbqcWSn5d43pbHQ3?=
 =?us-ascii?Q?4Y0ippt8jwjFO7SL8XGjeJS29M3NJjQVXkWRj7EXaqluj2bTfNvxvRYgoHPx?=
 =?us-ascii?Q?rQXKHcsgpFsxPy9vqNZs7OWQhfaOudq4U4t+T6aCTgavY0hiT9xnNqrye7iG?=
 =?us-ascii?Q?zsQhccp4sus+7H3cC2/1PBpRSRnnogoLQd3MWF0b2lCp0T4TaMij9kDgq2bq?=
 =?us-ascii?Q?HH7Nvy3ORhn3LjeUBrRyiPegbtLZw/hzCfyGlcDqxBd+4b6BdGOFWQsmlATj?=
 =?us-ascii?Q?vPo9RbLiK3LVVJfCqlxll+vgjvPeF3ud63XVCqBzu69PlSXSAiWfCIypnPq/?=
 =?us-ascii?Q?S9vVQMY9qpBbwjQQB7r+HHBDntutpnLCcFcn+CnzQWyYKzEvXxY4i261IPMv?=
 =?us-ascii?Q?GUGbuYS5+fwGjMypAHxlDBEgxYzhIS/yw0Eb9LvEbE45WLhu5B6xTEBeOhnm?=
 =?us-ascii?Q?lcNagPMxBIlev20MytMatodD1RYkVqsWmY/hAWeLdyjQ0/KSUN9S4dGdKVhz?=
 =?us-ascii?Q?+5ojtfPYd77T5gT9D4ZDMDeI7Fby7fvr0HCqmfW+UdBSQN5fq0zM3s7VMyDO?=
 =?us-ascii?Q?j80KaraRCw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc4971-77e1-4e97-d6e2-08df0cc3cd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:38:41.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk5HQ3jNGlrOf4W478rBGGgubL8juPcK8DOTQZ5Wz5KZXtP28QbJ7mu5otH/R6xo5ReUUT306pMlyRzcxF894w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: 04 September 2026 20:09
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; jgg@ziepe.ca; kevin.tian@intel.com;
> kbusch@meta.com; michal.winiarski@intel.com;
> satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> alex@shazbot.org
> Subject: Re: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and re=
port
> state to userspace
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, 1 Sep 2026 10:31:58 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > Hi,
> >
> > Currently, vfio-pci takes almost no part in PCI error recovery. It
> > implements error_detected() and neither of the other two callbacks. Tha=
t
> > one callback ignores the pci_channel_state_t it is given, signals the
> > error eventfd, and returns PCI_ERS_RESULT_CAN_RECOVER for every error, =
a
> > permanent failure included. Nothing implements slot_reset() or resume()=
,
> > so vfio-pci never learns that the host reset the device, or that
> > recovery finished.
> >
> > Userspace gets one eventfd signal with nothing attached to it. It canno=
t
> > tell a non-fatal error the host recovered from apart from a permanent
> > failure, and it is never told when recovery is over. With nothing to go
> > on, QEMU assumes the worst and calls
> vm_stop(RUN_STATE_INTERNAL_ERROR),
> > which the VM cannot come back from.
> >
> > Any device assigned through vfio-pci can hit this. A non-fatal
> > uncorrectable error is reported, the host AER path recovers the device
> > fine, and the VM is killed anyway.
> >
> > This series lets userspace observe host recovery state, and keeps it of=
f
> > the device while recovery is running. With that state visible, userspac=
e
> > can decide what to do with the guest rather than assuming the worst.
> >
> > The approach here comes from an earlier discussion with Alex.
> >
> > https://lore.kernel.org/qemu-
> devel/20260707161234.23ed28db@nvidia.com/
> > https://lore.kernel.org/all/20260818083754.7ccf76d9@shazbot.org/
> >
> > Design
> > ------
> >
> > The VMM watches recovery. It does not take part in it. The kernel runs
> > the recovery sequence and tells userspace what happened and when it is
> > done.
> >
> > vfio-pci already has error_detected(). This series extends it and adds
> > the other two callbacks:
> >
> >   - error_detected() now records the channel state, blocks new device
> >     access, revokes BAR mappings and exported DMA-BUFs, and quiesces
> >     INTx. It still signals err_trigger as it does today. It votes on
> >     severity rather than always claiming it can recover: CAN_RECOVER fo=
r
> >     a non-fatal error, NEED_RESET for a frozen channel, DISCONNECT for =
a
> >     permanent failure, and NONE if our own quiesce failed, which leaves
> >     the rest of the domain alone.
> >   - slot_reset() is new. It restores config state after the host has
> >     reset the device. Nothing does that today, which is why a device
> >     comes back from an AER reset with its config lost.
> >   - resume() is new. It restores PCI_COMMAND, unblocks access and wakes
> >     waiters.
> >   - A new device feature reports the state and carries an eventfd.
> >
> > A non-fatal error gets the same quiesce as a frozen one. The host has n=
ot
> > finished deciding what the error was, and can still escalate to a reset=
,
> > so the device is not the user's again until resume() says so.
> >
> > The support is opt-in. Until userspace installs the recovery eventfd,
> > generic vfio-pci behaves as it does today. error_detected() takes its
> > existing path and signals the same eventfd. VFIO variant driver support
> > is not added for now.
> >
> > The uAPI is VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It carries the
> > eventfd and reports a status word plus a sequence number, so userspace
> > can tell coalesced notifications apart. IN_PROGRESS is set while a
> > recovery is running. CHANNEL_FROZEN says the link went down.
> > DEVICE_RESET says the host reset the device. FAILED says the device
> > cannot be used again until close and reopen. ENABLED says userspace has
> > opted in.
> >
> > A non-fatal recovery can complete before userspace reacts to the eventf=
d,
> > so IN_PROGRESS may already be clear by the time the feature is read. Wo=
rk
> > from the sequence number and the status bits rather than expecting to
> > catch the event while it runs.
> >
> > Patches
> > -------
> >
> >   1-3    the groundwork: the recovery state fields, the open and close
> >          lifecycle so a callback never sees a half built or half torn
> >          down device, and the access guards the rest of the series uses
> >   4-13   close the access paths one at a time: function reset, config
> >          space, ioeventfd, BAR faults, BAR and ROM, interrupts, hot
> >          reset, runtime PM, info queries, DMA-BUF
> >   14-18  the error handler callbacks: slot reset, the INTx helpers and
> >          the quiesce that uses them, then resume and error_detected
> >   19     the uAPI a user opts in through
> >
> > Locking
> > -------
> >
> > Blocking access is the hard part of this series, and it comes down to
> > one rule.
> >
> >   recovery_lock can be held while publishing state, and while draining
> >   operations that are already under way. It cannot be held across a res=
et,
> >   or across anything else that reaches pci_bus_sem.
> >
> > The reason is the order AER arrives in. It enters the driver already
> > holding device_lock, and pci_bus_sem too when the device sits under a
> > bridge with a subordinate bus, and only then takes recovery_lock. A
> > secondary bus reset reaches pci_bus_sem. So a vfio path which holds
> > recovery_lock across a reset ends up taking those two the other way
> > round.
> >
> > Seven places needed reshaping for this rule: device close, slot_reset()=
,
> > open, VFIO_DEVICE_RESET, the guest triggered config space FLR,
> > VFIO_DEVICE_SET_IRQS, and a guest write putting the device back in D0,
> > which reaches pci_bus_sem through pcie_aspm_pm_state_change().
> >
> > Most access takes recovery_lock for reading and checks whether a recove=
ry
> > or a reset is blocking the device. A few places cannot take the lock an=
d
> > read that state directly instead. All of them fail safe. A stale read
> > costs an extra refusal or retry, never an unguarded access.
> >
> > Interrupt teardown is the one deliberate exception. It flushes the glob=
al
> > virqfd workqueue with recovery_lock held, which can make the hold last =
as
> > long as a reset on another vfio device. It costs latency, not
> > correctness.
> >
> > I am not sure this is the best way to handle it, and would welcome
> > suggestions.
>=20
>=20
> Thanks for tackling this, Shameer.  The recovery_lock wrapping all
> these accesses does make me nervous, both in lock complexity and
> overhead.  Wouldn't it be a better solution to decouple the user
> interface from the device by replacing the access path via SRCU then
> doing zap/move/interrupt teardown?
>=20
> Such a solution would have utility beyond the error path.  We could use
> it for surprise removal/DPC, we could allow a policy to remove the
> device from the user on unbind, in place of or in addition to the
> request eventfd we use currently.  In the error case, the intention
> would be to temporarily suspend access to the device, but if it falls
> off the bus after recovery, it may turn into a permanent removal.
>=20
> What do you think?  Thanks,

Agree. As it stands, it looks not that maintainable due to the lock
complexity and dependencies.  Let me look at replacing the
recovery_lock with SRCU and see how that evolves.

The generalisation makes sense too. I will keep this series to the error
path but make sure the mechanism is not tied to it.

Thanks,
Shameer

