Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671412F6184;
	Fri,  6 Feb 2026 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357658; cv=fail; b=i37hTHib7Wt9fTy2C/DoT+Bm0CWVA/McNA2cUo9PO9euRL0yAJ3VsWufoKl1NQeG3IjoVtaM+dwjB1ogm4fm5OLxh1EP45jIl+FpBFjqnh2WPljBUFsevaRwCwpOGoOPpw2A2WsehXM0scljWbwpylBtosRUa1aajW8mTgKPCNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357658; c=relaxed/simple;
	bh=GOhMCqv6pZMw2xd9IWFTixkzPobfDL9UWYR+HJfn1zo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LHZ+G1kFPD6Q3tDmiP2Avdovd9YItaRNw+6iD4j11NDR+7Q6CEJMqpk239vrTuMmPrLLcqfrNI9InKbPSDxy/TuECplafIbhW4scqZ5zMfSwSWy/QEd5FamikUOPOr/zPxCBv6plhsKY8/g5f9wKVDyGYhKXpLlZ+LjL0GJ7B/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1SExH2/; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1SExH2/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOzAXxr2ugTbxQ4LfoYTYHm4zq1BqhW2x9jCUXCN1joiAsif1ZQI5CRJ7dZ/4HCZ2AsmwMJwem1e0QfeZ0b3ncTW+NoUWpY6MNm0IvsDmFD6148uxf6ZZ32OOVV08u3wf5+KnHk+9HKkSLWZdFu20yY6iKGNpX/phavRwenbGzjgzqyCMYQn+ckFZXm4TmFi03ROhBfZUMaEORt8Im94dcQKXWL1t34wVgp92xKFxvZ9mOCMnBHBTg5O4rOvogCfmjvQugAnCec128JMPYDQQr+2mcNDiDZPD6drpHxNUmRh+BkBr3SmVg+XP2dgJvCgg/RZbVXN5jsRkJL8YZZeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1k18Gv23zOPQfWKDDS1QXoEFklcveXLLqmjdV7k7OM=;
 b=VcAPZqrcCV+7fSz7HTihxT2vvYoCSWTOFFMaWpzU8Ms79bmQUwtK2Oc82kjBRierrc4f0ucJVVNRg1Wlf9jPmnSSSrwU98qMlW5YPu8q2qvI4mvFXa5Vtie6+H+Z6zhefS6Z0KPN6zGIHlJcTlbj3lPe9Ho6aOQZ4dxzCcwrhMV1lbqFKWyPm3fPv9e2SwdoP6rGa4sE9BcN0Uu14BNZF+suboSrY3q8TYZRgkwoLZUZo08jAGNhefXIyNZxan/aFRKVUlhWt/usLJuUJdDBnH6na4qbqW2PFqnRhQWXra0S7js1DtrAfZt9YhlJkul1aLQi/j/svWnxhrHj1evtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1k18Gv23zOPQfWKDDS1QXoEFklcveXLLqmjdV7k7OM=;
 b=N1SExH2/WYsX9vHzZUWH4sAnZgnyVJ5jl8K/L5Atxb7nA164PivACBmV45ULMHE6MAjbcNh8apmkk22ICp1GUbvdlqkMh3yMOumBrJTJZ5k7f4UMIjFJnLqk20NritVOY/mhmi57QpmIh1bZhQGg10RVIzcUyQgMhg8/guDG3ZTLzEmUA66K35OzRL9vCJL7mVxPHknl3fckQA8MdA3TXPGBDylARD6hRcmQDR9Hn0kAw7AH7LWYm9pk5HLko2Stuz6AzPVWr+Iy6RZhnIDNuho7VlFIJaGiLuG84VTk2SrXLIVOG5v+mm7BIY229lt5ccrBN1xyyA5I8nY7HZLn+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:20 +0900
Subject: [PATCH v2 6/6] rust: io: remove overloaded Io methods of Mmio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260206-io-v2-6-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OS0P286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec5bf18-3d5c-42f3-9689-08de65451656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTFjNmkyWmt4QUNNUWl0Tm9GUU9tSjlTSUtHZU5pMVVndStBVXhLMEE4RnN5?=
 =?utf-8?B?cFZGNnBkZS92SWU1MWlKTmlYU084NXNCL0hIcTc5QitpeWFkSE9wa0dTOSsz?=
 =?utf-8?B?SGJXNXQvWkpHWGR3RzZPaGZ0Y0xiWkFXRExxOUdlck83aDVLNmNBRkVuTWZC?=
 =?utf-8?B?NktiNmZVWkhLOW1reXBkRm0wUHV4SUhscmhQc0p3ZWVEVFBLVVBIWXdSNWcr?=
 =?utf-8?B?M0k0VHMvVVkyMEs5U1Q5RGRHdGczY0k2cWpKTXp4ZVFubjlJRHM2T3JMeGEz?=
 =?utf-8?B?aWRONitKS3dQejZkQzNIMjFOUHJkRkpGdEFkNkdYc2NWRVRTOGNncHNiOWxS?=
 =?utf-8?B?NUFrUThWZHcxZzQweEJzajNkZHYzQmxUdyt1MXlBUkFNODFkMDFXc1NnRHA0?=
 =?utf-8?B?MkdwbFRoc0h3NzJSaGZKQk8yTTFZdWVDTE5VeUgwamR6d0JZV0RxMGt5c05k?=
 =?utf-8?B?VUNXYUZQOTNncHlKYjJtT2hiZFBrWTFzWTVPVWRDT0NlSStKcWJEbDRuNXVT?=
 =?utf-8?B?MGZENnVoUUtUN1FvRWt5NWxqcFdDaFN5eWNzK3ducGE5L0xSRmFDUUZucy9N?=
 =?utf-8?B?WUMvOUxFVXFrVjA1TERJdmJDeWIxWTQrRk5LdWw1Nm1FdkdPZmFDWjNodE9K?=
 =?utf-8?B?emdkZUpXRW5zbkh4QUdGdTBoa0lNZzI2VUF3NkNyNlU4cm1RamlKazZJODVE?=
 =?utf-8?B?KzIwQ2s4RHpoN2tmOVJVUWMxVWhLR2RpYTIwOTFSWklvYThzN2krUEpHajFT?=
 =?utf-8?B?ZjZrV2I0VUlDcmhITXZieVVHK2N6M0dZZjBzL0FBYm1rL3F2K0VQdWNqNmk3?=
 =?utf-8?B?cTVnZE1penZ0ZWRaUHNuZnZpTEczd3ZLZ1pDbkRjKzFFL1JiVVZ1ZVNpS08y?=
 =?utf-8?B?NmdhQ2V5OUFDdVFQNUI3ZGwxaXlRQkVhYk9WbFJMNkdTNGlDMW5tQUphZzhT?=
 =?utf-8?B?Zzg4bkhhTDN5eWxPM01lRGJ6ajVsc2dVdHNGcVl2QU16aDhVMlc4UC9xYW9U?=
 =?utf-8?B?NUszOWFzcXlkajhmWW9pOUdTSlVFOTQwa2xwcUtjUEhpTHdGY0Fpa01vM3hr?=
 =?utf-8?B?Z1lxWk5UVzI1emswQW1YTG5jWWFXK3cycndxM01BZHFwL2NoSjU3RWFLK2Zr?=
 =?utf-8?B?M1Z5Y0JJcVY2YVZ6NmxXNnFnTzdiTStVWXVDbFpTdjVmdzF0QXdLdmtqei8x?=
 =?utf-8?B?SjZVUDJvTkRxZ2lPTkFGbTQ4Y3FlVXh4aTZMN1M3T2hlVmRjdDRHWThoQTBk?=
 =?utf-8?B?azJPakx2eXBQSnNiODRCb1kzdWMvTjNNbEZmREhaQnZnZjFXVDY2V1RJZkpx?=
 =?utf-8?B?bUl1UTZEaXJwU3E0djVhbC9SOEE5MW5tdEU5MWpyUWhOL1NIM3dMb0hjSmdk?=
 =?utf-8?B?U3pPbk5sVlhxazM3d1NyUGF1QjlleWhHam43c0NQaDlMQ09VanhGYVh2STdP?=
 =?utf-8?B?bkJZZ3JNQlJWUXp3RVdIdEpLM3FHcmJFbkxyUnhzMHVvNVpEeUpXVkNyRzY5?=
 =?utf-8?B?QkIreVhzUjBKNUJyNm9QK1dteGNWRUtCYkZiZFJVdzNQYVlzcGlYaEdoQnRQ?=
 =?utf-8?B?QkRhV2Y3Sll4dVBYUWRXV0hrdU5xemhHNXc3QVM0L0JMaXo3QjJmbWRWRjNx?=
 =?utf-8?B?b214YVM0NThxVEMxRlZzRkQrU0t3c3pmRGhic3dPMDNhSFAyWkczYzNTdVo3?=
 =?utf-8?B?aDdac0tlTzZ1L1QvNUhmYUlqeVFBUnVZZnVpSjljcnRTZElqUHp5aHhjMHFZ?=
 =?utf-8?B?RFVjODdRMzJCeGxTNE4zRVNocGNLc21oTnRQdEhUUEdvc0dQcE1LTG42Y3Q2?=
 =?utf-8?B?UFFORGJwd3FZbUxQcndYdSs2aThyM3dSMTE4bGtzU3VMNXRPc1F6UFVUSCs2?=
 =?utf-8?B?U3Rma2oweSs4UmZST3hQTU1Rdm12d28wTldONjhabW12N3JiOCtNd1pKeUdv?=
 =?utf-8?B?c3JuRUxhTTNMRERXZUd0emJ3enZ5T2F5MVAzSHdPU0tnUFRxMDZIeTJlWVMy?=
 =?utf-8?B?Z0lNS0hIaHlET29qMUkxc3o2cEZ1VG94L04rVUlNbVd3NXZ4Z21jU0d2N2FK?=
 =?utf-8?B?UGFDVktxc2RhenRSTU9SYjN5REJ3eHhldHFXZklCbXB6eUtaMW9Td2l3MDlr?=
 =?utf-8?B?eGdjT21TMFJDSVJuN0ZWZVdiSTlLV1hmTlNmd1VjUnF2eGVjVG4wV0JGTEJE?=
 =?utf-8?B?MlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFdQTldNa2hZc2JIeFcvVGg3RDF1aEp3eE96ZGZYWjdCVVJpRE9tdHAwVWl0?=
 =?utf-8?B?a3Vxbngwc3NIZXFLR2grYWs4OTBsQk9BUVY3Mk5xYnJmYkc5ZHhsT1dNZmxm?=
 =?utf-8?B?RFpFbmFQZ28vdmlhOENVS0JRQi9tYmRGMFdBSThUb2cyczVNeFN4NW5UNW9l?=
 =?utf-8?B?YkIyYll4cVMwVEhIcUxuR1N6ak1iRlRxZ2huZUhQZ0xUWXgvc3Y1TncrNGs0?=
 =?utf-8?B?V0pxR1FRdFF2Q2J4ZjlVRGNnRDVzNVZsbHMwdzFkRy9qWmJFQm1lV0J1em1V?=
 =?utf-8?B?L1BaOFpuU3VKQnoxdWladGlVNEdUQ2VrY1VrdmtFVldKdS9EenhWaGZxLzZz?=
 =?utf-8?B?aW1iVFpyWFVwWWpjL2Z4cjRFa3MxVGdJR1pQUmkzdndMOUplRTh1OU5NQ1Nw?=
 =?utf-8?B?S0RWM1ZEZ0hXQWJtNitXQ0VoeFkxa0RzNTRnY3RoU2lZTS9WcU1MTUFVVXY5?=
 =?utf-8?B?ZkNJbjFhMTdFckU1RVFHdENidGJLbzlwMnd0dThpdisvd1FkQUVhTDVTRWk3?=
 =?utf-8?B?WVNVUSsxaENmNHQvakFxS0xaUHBoN0xzbVQ1Y3B0NW9VaTFuY0tMcXpiZUtu?=
 =?utf-8?B?elVGM3FGMHBxZUhyYkpCWWZYQ29UTUJOODA0akl0ajFHWjVQUFNaaVJHRjJ6?=
 =?utf-8?B?b3dGQXdqQTJCTEF1NWlrRHY0d1dQNDB3Um5ZZmI5RERlYjRGSjQvUHdaNXlq?=
 =?utf-8?B?VC80RDkrRXlhcWZBTjFyTHhIOTdMUkVGNFpiRjZ5WHl6bDFENUtOVEhuQ251?=
 =?utf-8?B?bGt4ZS9vUWtHSzBsSmJQdFEyUHdDamQ1SUdTQTA5dkpIM1RjMkNLN1krQ000?=
 =?utf-8?B?YThBczNJaGFTTFdTTFZES01rTndnZGQ1U3g5Q1RBb3FIL1UyeWNBV1BqdEpN?=
 =?utf-8?B?ZVFFVElIbEl6RHFSczVDMTRkUWJ1ei9IeVREdU5pNWRNSVhMcmdkQ05GVWdm?=
 =?utf-8?B?TEJhWmUydktuOVdwcVlxUldpVFFWd1FsU0RXcW1CRWo2aFNhQ0RzUVRZRVBx?=
 =?utf-8?B?UFZIaEN4RmhDc0lYRXZJUTExNW9XTXBzTmYvZ1BQS2kwYUJwZ3NiZjI3YTAv?=
 =?utf-8?B?ZGo2VzZYNHBjYVgrZnVJcE1DUzJub2ZyVTkvODVDZVFFUTNocW83TzV5MHJt?=
 =?utf-8?B?d2JMZTFBUGVBTjZDd0I5ZlhjNlhJS1BTOWFoRE5LTkc5Z3BFTjZSejdESkJR?=
 =?utf-8?B?V0FIOGNoTFFjSTVIY0hpN2pQRUd4QkJ5TXlqVmdKZXlmVk90NGJSNDNlczlw?=
 =?utf-8?B?WENkRGt4YzZUaW9SU0FlU1R6b2hHTzl0L3p2TGJTZDNJWFU3QUw1M254Nm0w?=
 =?utf-8?B?U1pKYyt1K25oM0RRek9YUmRmeEw4RUZ1dVYxTEFYM0M4QzVEYzBGYjdvOEJz?=
 =?utf-8?B?ODlFcFdjbDJrb2dDNUV4cU5HZUtuRlhxSlR6VVNkc3h0V2xwRUQwZEt3b0lO?=
 =?utf-8?B?dU5NV3VoZ0dPdVRWVEQyWUs2S3RBWGpEYWg5bWNaU1Blc1Z4T0M2Zkl5UlFa?=
 =?utf-8?B?Ukd2emlQVXdQak5HR2kvSXh6VWVDNFZJTjJjMmcxbkF6dlZjNEhXQU9KNEl3?=
 =?utf-8?B?Zm9ia3RSTjYrV2xvd2lEMjBINFY5OTZLbnBiNUFvZG94S3U4MEFXUVQ0bmJz?=
 =?utf-8?B?OE85c3ZCbWQyRGZFc2Rta3EyeTMwa2Jsajl4b1lPV3NxNE5scFVJcHI5ZTFz?=
 =?utf-8?B?NEhKVCtMN1VEcS9mM3lBRWhKSlU2RGZqVmtNVWxXOUxEc0lCSTNnbUdhbFFn?=
 =?utf-8?B?RTN0YmxrUjdNVVhTUVBUQnRiVUtJd0lwZlpXbXBwZk90dkNwZk8yaHNmdzhk?=
 =?utf-8?B?VDdqSStwNXcveHViU0haaE0rV3dFamhyUVN1cUhJa1RCVkhVb01mQUkxY0hI?=
 =?utf-8?B?SlgzVVpIZGU0VFRCQzhrc0c3cGVRM0hHRE1MdENBWkhNQUlKSnAwOEowaXNz?=
 =?utf-8?B?YSs3c2xaSDBMSUdmeDZ3VHBjdTlIQTNIZWZUUWJBczNoY2JLSEs2cTRjMXA0?=
 =?utf-8?B?dmNEdC9DQ3VWYjJDY0FNZFZvMmRrbGJkUXJuU1o2UElrdWlJd3czeVN2V2Fa?=
 =?utf-8?B?VmR5dGJvSW1ZZG11TWN4WitTUWhoYkMwQS82VmQyMVRTYmtIakFVVnVTdEtP?=
 =?utf-8?B?UmZnNzhnL2Q1YnM1cmdGVFlNNTEzektWekZIbVdLRkh1OVAzUTNrZUtMS0dp?=
 =?utf-8?B?TWxYZ3VjZXNVczVmajVuMWg3eU1sWVpvR1JDb0s5YnM3WEM0OTduNnFTVEJp?=
 =?utf-8?B?TUpNaVRjdnVWRVh1L2E0OElZM1BNQnJkOGdIWUQ5cExiTXBhT1JKQTdCcGRT?=
 =?utf-8?B?dERtcDdIWFhQMEdlRmhIbnFia29BQXBKOENJUDBMWXd1S21tRDZEQTFpU2Mr?=
 =?utf-8?Q?qiHUSOO5sOYDRyBIqavqnsyOHOUq19BUAMQOn9ODFE6KK?=
X-MS-Exchange-AntiSpam-MessageData-1: a4J+K3uathEmKA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec5bf18-3d5c-42f3-9689-08de65451656
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:53.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6KPPJSegJbBkew7YXr3B6HPVAfy/uS4mgDvXsiqHrV+YuVFWrpS3rdKFvH5C+d2y7MlFhAVMAgFmkoNup9mgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

Since `Mmio` now has the relevant implementations of `IoCapable`, the
default methods of `Io` can be used in place of the overloaded ones.
Remove them as well as the macros generating them.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 161 ------------------------------------------------------
 1 file changed, 161 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9874edda2b28..b150743ffa4f 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,127 +137,6 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Internal helper macros used to invoke C MMIO read functions.
-///
-/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
-/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the MMIO read.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the value to be read.
-/// * `$addr` – The MMIO address to read.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_mmio_read {
-    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
-    };
-
-    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
-    }};
-}
-
-/// Internal helper macros used to invoke C MMIO write functions.
-///
-/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
-/// a unified expansion for infallible vs. fallible write semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the MMIO write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the written value.
-/// * `$addr` – The MMIO address to write.
-/// * `$value` – The value to write.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_mmio_write {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
-    };
-
-    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
-        Ok(())
-    }};
-}
-
-macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
-     $type_name:ty) => {
-        /// Read IO data from a given offset known at compile time.
-        ///
-        /// Bound checks are performed on compile time, hence if the offset is not known at compile
-        /// time, the build will fail.
-        $(#[$attr])*
-        // Always inline to optimize out error path of `io_addr_assert`.
-        #[inline(always)]
-        $vis fn $name(&self, offset: usize) -> $type_name {
-            let addr = self.io_addr_assert::<$type_name>(offset);
-
-            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
-            $call_macro!(infallible, $c_fn, self, $type_name, addr)
-        }
-    };
-
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
-     $type_name:ty) => {
-        /// Read IO data from a given offset.
-        ///
-        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
-        /// out of bounds.
-        $(#[$attr])*
-        $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
-            let addr = self.io_addr::<$type_name>(offset)?;
-
-            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
-            $call_macro!(fallible, $c_fn, self, $type_name, addr)
-        }
-    };
-}
-macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
-     $type_name:ty) => {
-        /// Write IO data from a given offset known at compile time.
-        ///
-        /// Bound checks are performed on compile time, hence if the offset is not known at compile
-        /// time, the build will fail.
-        $(#[$attr])*
-        // Always inline to optimize out error path of `io_addr_assert`.
-        #[inline(always)]
-        $vis fn $name(&self, value: $type_name, offset: usize) {
-            let addr = self.io_addr_assert::<$type_name>(offset);
-
-            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
-        }
-    };
-
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
-     $type_name:ty) => {
-        /// Write IO data from a given offset.
-        ///
-        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
-        /// out of bounds.
-        $(#[$attr])*
-        $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
-            let addr = self.io_addr::<$type_name>(offset)?;
-
-            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
-        }
-    };
-}
-
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
 #[inline]
@@ -594,46 +473,6 @@ fn addr(&self) -> usize {
     fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
-
-    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
-    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
-    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
-    define_read!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        try_read64,
-        call_mmio_read(readq) -> u64
-    );
-
-    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
-    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
-    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
-    define_write!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        try_write64,
-        call_mmio_write(writeq) <- u64
-    );
-
-    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
-    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
-    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
-    define_read!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        read64,
-        call_mmio_read(readq) -> u64
-    );
-
-    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
-    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
-    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
-    define_write!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        write64,
-        call_mmio_write(writeq) <- u64
-    );
 }
 
 impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {

-- 
2.53.0

