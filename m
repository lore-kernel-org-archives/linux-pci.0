Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFD3C2D;
	Fri, 13 Mar 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404733; cv=fail; b=AYGFWwjtq9Ns2DyJn8lFnAdnnLvJbnZKUkV5dRknVa+9BZghYxKELX2/P0ZpWS+IudUC/rMgkZAAURG2xHNr7LBOquy5sCJnKtRbC3zyRo48tqauc+d82/01aVMLyvIcAthVVPD0G7I+mDHW9kNC5yf5o7S95bOuk0ZKVgbx9fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404733; c=relaxed/simple;
	bh=idcrNelrWhRT+hp1LqZtHLvzMR1XekpLY25hkO8UcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOR6UBTThLTg0QixT1uXEwLg7lzo6gpUiQcOtJZFjM8EwdY7CEHa8L4F8B+LBItGKgAFL0DDqNZaxMH8sIR/exGzvCcwNoBH2FXuu0LtJOOnlYnq17EiNidj11+Ftf/qoKqbZ9xbypb1riBAAqypQ1rLibTIQWMZ+F1/m+sbg+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7FPv1r6; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7FPv1r6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+Jv/cqj3AZqGlCVFH2tRR/SwzqoxiVxjIWXyFsuH0stmcV0yc+odFkLmotMrEQB3TbHC6JjkRa9gjJMqRhAurx0Iv/KGLk+UZMgXe6OsHaTyIpRaiH8Imag+FcL3GeHi0dh4uCaZg3KwV7i1ORM/rsuR2J/TiOVCCCQ3lhvrOoIMv1ORtZ5JPwJblSLWQDuUp9pppdIwpMoehQQR/snkj55iOjmi5osdYQ9vaeSP/wLByMW0/HE5S0lv0YglHjjuQU7tuTiNoUneuQVf6a754sip0q4aoUtg5hJIthVQ1FljiQT40Geu0Ct19+A4b71oP0LWSUXfpKjiyUf9GXLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idcrNelrWhRT+hp1LqZtHLvzMR1XekpLY25hkO8UcA0=;
 b=aahF15FWxZze0qSpDt+TK2rSJDBegTWsr3SLrJEOe/kJ6YIpySKI8Rkd1jTELEqRZLaAFOAS7i8YHX+whvTrpMx1ZMuZ/YWDgjXhdipme8osJz7OTUxeqx14Tc24RT8c8kuHS1w2kn2ZRmuQIJrR4s/kypDeaURJf5Il5k5NhGxv/ZPLZZWud1PxbDygwYQ4FFsvhZWVrjL5Iq3RDwamwQOMFfp4scCq+5gD5cj8RQXRKv6DD1eLeIgo6NiTXlurMn+4SIN6R+5Wv6qE4D5NRGSefCse5L3ROWbCWztCl2QyKNjFSbiRPNlmE6ZSMB8AO8Veva124yI4bct4Lv/Blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idcrNelrWhRT+hp1LqZtHLvzMR1XekpLY25hkO8UcA0=;
 b=W7FPv1r6i+8Y5pbkNr3195+Gkf3Q0ZvoluCSvCTn0reQcO5xjQd0ss0zlK1nZZE/88tknGEVbIbhXfqcAHqEsygnn0MU8o5VluAltaE6dPO7MwBvirDyKYquXZoI/uMxUblDzB14diAnEE1coxfh5Jt5xotPyDAiwkfs4Rmxy4xlkF3oinKxpnEcbgIZ9cHH6ZKGiIfLNhpHCy1Ug1WVgJ/2Omg9HLSX0XK4W23/r/8T9OXbygc7B27/ixHZQ6b+MEpNP1JJ19K0+wePrrm2uACHFuQWES60z6bRNS3KGDw+95r3ci/wn3GCelcYk0pexEqxGKerG+CVyFvDIsRRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 12:25:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 12:25:27 +0000
Date: Fri, 13 Mar 2026 09:25:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <20260313122525.GB1586734@nvidia.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org>
 <20260303210733.GG972761@nvidia.com>
 <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:408:f4::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: a897b295-5266-439c-57c8-08de80fb9b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MMQX88LAAT225OuoAupVoT0P7I1PZPJPYRxXUdOAh0xe7k3XVlVK6Vncy4yFMqHxlxF5fB5pH4pTLQmMpxdpJ2bTeYS5xozL8u49HIsBFVsu3zCZGf7jY5GI5Dx9fwsiG3hT9yvBTnzoi2mtHib7zK3Rqs+L1az2cn0RHH7Wb4TMb1ZtfAcQLalN0Nb8InBNwuHsFOhR7VjuCFN/VQMo3ZQUdluLOFeOpPSYkg87FW6zokeWhD2MGGVBQ6l5mFUylQm2dmkCGSNEIYsXsqx5n2GDUmynhOywQGPpcrxxEIjGQUL242zgVHucVrtjhnNt3NyXH9fudAkRjqkDYJ+8wxVREfFipi7TjoKvjR/Pzrbpo27trlS7ZBgRdXBNgCDH29TzhyMQv2wnS0wL2h9SNY2SN3vTNh3PMKbK4JVbRGQ9Jpj0xUf/muXfnbGjDMfeSyCB2jBJ3g2njwO8Xy3+5kfIc/faIhVEk9BRkL8Q+FS5sn2gzTrvf+t2VNzNN91Ui9xusye4Q3A/n6+9hnFRJjAnyjOCtBlVrj8Do0OzeaL6m0rf7r/rS0Feu7Uw/iqf2hriBPyqn2ht4tcDVSCfKYs1/CJObORvcaj8O1UzWgJ/osS+jipURQzaIRZZosRGkrh8Xqq8JbwxT0MGHU0yycaQFhNwdZVb6dVSK2wUwvBtIy1jzSyRhJxzyAFtW/Xksxs8dq8afMZEB0L4UHl4UzEYgqrDMPz6Ym0I5F4x4rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WRdsjV8JarRq8xe0n8kOcWH3XRXXICr30V4x94szwr8jd/46TRBxbhfFdwC8?=
 =?us-ascii?Q?hYeN2V0hbVDq46Dxe0qzI8kwpXoqVzCOGmdywIOHLnPEEbp1p8c3BrPlhLlv?=
 =?us-ascii?Q?KLdAggJInlt8Sgm15TiyL1dZNjDAQiPDb8KaQpIG5HhiLPacYtSnRxjc2FDP?=
 =?us-ascii?Q?akzuu6w/vMc8LhdFpNghzKOn3suhjwovbAAR3ec5r3TqHUcKAvmtZQIhxLyv?=
 =?us-ascii?Q?5kU+hjzJ+UeeZ+N07WTz3bQ/O+OfvZOENHt2hNptyKEMWlSzOu44VX9ODf41?=
 =?us-ascii?Q?H1chhipOsWw36RybdNjZu06TPORR2LxUHk79+zfVR81U5OslAnfqCM1TxMIy?=
 =?us-ascii?Q?U9Li9tkK6IFBuZ2C0mjgsExvYphmRH+WC0CVt0kE/8q9UEgQpoh7NKxWSKrm?=
 =?us-ascii?Q?cnF5mXcKIgZaorTuhGKj2hKqnJZw9Fdakl01kp2vHlceQ4lTVxrxnB6l6jOM?=
 =?us-ascii?Q?Tl8Tgqs7gDgH4ylTjoE+wIdbF0moruXRT5E6LRmJTx+yTKGdJmEhWqWOHEWP?=
 =?us-ascii?Q?EY41P8G2/1uwIu3/P1rAMTv7I04V+wWddlN13zc7VeQyA1H8GxWGyad3QaLy?=
 =?us-ascii?Q?/xEN+HMs67oOHzVqznPfl8aydpACFu+63HeANzZztJTYXbV9p3atVUgtya+2?=
 =?us-ascii?Q?53hqnN/xFbqV727Io7sdAZtqUO57FKPhc09jeTdhH8JpmL6lgwtqO75EJIy+?=
 =?us-ascii?Q?qBN5eOkKTXzLyBtfGSzoNCerMYkaKLjKadP9bukKbHT6tbtLY/shFXHbtrde?=
 =?us-ascii?Q?ai+P7XOsm9ssM8QM+g7jLBLQjmBrGd+QVn3PxOv6UbfHz/eNq+Y5ToCPBiWU?=
 =?us-ascii?Q?p9AsDmyrhosFLedx31uo1fIF1W0HLVaxpPeMyA0boRWUnC/6REfcpfo+Gh/H?=
 =?us-ascii?Q?KUSDDvaSfIHC14s4gOH7T7t4mOuySr5ytZlMsDlXBC22St7k7oAGGbKaftTf?=
 =?us-ascii?Q?HaWnzMtCCMcP08lK4hsx8IwkOshAtuGKUI4u4KoY6mm/HLnvUGZ9AMopUJyK?=
 =?us-ascii?Q?HjzgH0itOu43yKkGhz56JMDVagqF+sVMNJuiNPdR/6qF+xIE8KBhs/zvMk6E?=
 =?us-ascii?Q?eKxjaZ1q2YA2vwItEZECwYf3qE7sNP7G7mvbmbaVJ4djLEjym5yPO1L52vac?=
 =?us-ascii?Q?SFI3hmMYxkJxXsv2GwwSc+SEwkzbrqgHdBIhNJ/rfqyyc6UchK6fLkvKgv0r?=
 =?us-ascii?Q?uO6sgGQko0zk4hAnUPEK/YldWKTJCZdhySgYme43u/L9lI2x1CSC2jzwcGLN?=
 =?us-ascii?Q?590z4aZWZRucqtpksSHz0uSdnbmdXrySb/fp8fMWa4eapD0nIHV6iVQg/o2p?=
 =?us-ascii?Q?+xBZ4L/1xQ4C5gCP97WR4a0je6cmTe1DBr5ABWFPZS9FY6gNgSmCx7c7Dgmg?=
 =?us-ascii?Q?A+y1c4LG6jQJJ4E3xZNw9dvz1RYnXlmqgBy3X//ulDAETsZxS4OveMrdpAxB?=
 =?us-ascii?Q?ep6Rdo2irE4AI3IH/ha1iotBY+O6GJ/nb672iBdox7PNkbjAeRUo+8vuL7Or?=
 =?us-ascii?Q?7prWHAN7dy9M7aPsJPvgiETURzj9WyAdQeTSF1zmOB/xWfm9rK8JEJF2tjZE?=
 =?us-ascii?Q?BNomXF3KGOq+dDgatkkGLuHPXR+pJxr3HfXdtpys0zU6qVJqJJXD11w/lY06?=
 =?us-ascii?Q?J7WSkLYVQFiLimGZU1o9oLxpYKX3oqyoZhAzvMYWVtg+5PmBfCnAcsK0OKIo?=
 =?us-ascii?Q?6uApoSooWHbYVXZz/NorBgsxK4Lr7v4vrR9wf7uItBticlpB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a897b295-5266-439c-57c8-08de80fb9b86
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:25:27.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQy+zIXQFwKMMmod60bDIF3j/e8YPN0OinVZA+I7w7pOgtAUtn6KsNRT14SQumHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

On Thu, Mar 12, 2026 at 08:33:27PM -0400, Pasha Tatashin wrote:

> If there are active sessions (incoming or outgoing) with preserved
> data, how can we safely unregister while they are in-flight? It is a
> rare condition, but since the user can cause it, they need to be
> notified that unloading the module right now is not a good idea.

IMHO blow up the kernel or something in the core code, you can't stop
module unloading once it starts so it is pointless to propogate this

Jason
