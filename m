Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DD545296;
	Tue, 22 Sep 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081690; cv=fail; b=cR0jIcx8uXxpCclF+SFjkNTkd6w/LNHTEMyhN3i2s4P4Uc7r4f5mvPNtpXJq2F9wO9F4H7WPfi9w1o6wHEsbPF47s0COs0HZPIWPQ2l1MzjCwO1icWneJicx5QZc9VFyFCSHBdZ+9gV9XmSvLn0nkRnuIGuVPqwPCvCn92RtJ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081690; c=relaxed/simple;
	bh=iseBiaxmMr64Js6HebyGG6kCCXNbl+eGuLzSrYeIHrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4rgC6r3VIoTG/4m46/I9nYdL3vAmgmliqY9DK7IfzmE2io+YVkh9iFq+kiet/dFpVsimgGAC8v06oZ1GAEti3x4f0qlwOA6ch4pU2HkP/qoJKsinAg4ripoLUp627155O/8NhI4Ml5jyzWpz4NMRGNrE/PQXVl/adoYmx9172A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdT6TSPt; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdT6TSPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3J1ittVGrjCIPEi1KH3BO1K5eo1dFFx9rFoyFp+n8uje/OCjjs4AVPNdspVf5d6MeoCT34ip3jxuv5gEQBIj3xHQ3x2gKrm6jGPwBIThPYhUQOoOKGLKkS68AvO4mru1smxAiamdRMRX6c/u4LX+askp6YrRaboVwy+z33gXeCBARzFUZHsxFljJqpc6/gBxYo6eQq9Vh6FF0z/KDtlARSUSJeLgiK0OEbUhpyZ2uBDlALRwezs6FevbE/nfijmHL7oaoHKkjTP08KR05KcXGoZUBwKLa9TAg8HScUwevMPgi+/Lc9HtKSzY8nXJ5YCMa9IFoGQy3bhgmDJsQgFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WynCK7i7VNcnkYpfa8Gg16EWNRFCsoReR0SLXstCy7k=;
 b=MgHahxkPNkroobd3n5YLzdVMKcpx1nYFu81eNeyAe5xgMmotVPi6bR9gNYjk7z+SUnigdR0hiTIzb0zXikXxJkTRFBFPulIfTR2/KQVesY60U3AwGS4zAhvTxQ66ou1PSI0ch94zybOO2vfDdQc7FinSMeqQ49M33LrFq4NSeJTu4enTeAIYCxfdckh+mZml54a/bKdQ+dXMNKycq/j55OO29hfc/7+xwF+ztco01MceCRT4TIouCvHRtGpzTLqweddhHzQqz8f9alZnI9EMfJFWW4qXgsyYyVBLISxzUICslso0ciep6b/mpLDQyFwCwpMpJPy6zvqeQOwcuHST0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WynCK7i7VNcnkYpfa8Gg16EWNRFCsoReR0SLXstCy7k=;
 b=fdT6TSPtEWgDCj1Lbo3SNhmUJDBlE6oLSyxL/N9uZdZM0DiFqaqU5K0ny/Y1S2fKVl42BvNycWhl0jKHOQyfyTpsOsdDLrv8KegNIYBJ3KeuVrFVoegq5MY+2vBYysPPLxipc09+xFYh1RaA9B38Cw9dUBatvaRKT57DlEwslByQcqKGYzyrp1ghDpEV49VDEOQDQltmR1xOQxlbCbployf+emUedTtFOH3Lb9ajEk/saViUcO8FoLjAoAhiLhac0+Hm++H3ugSGRsIYIc9mMXpLhwaQE2iSCGc/F2domN09Fg2wc7sUMJ22Ry3BD8LIyKRz3wxaNG0m2Pzc9gZ4pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB6301.namprd12.prod.outlook.com
 (2603:10b6:8:a5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 12:54:23 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 12:54:23 +0000
Date: Tue, 22 Sep 2026 09:54:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260922125421.GE1507824@nvidia.com>
References: <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922124637.GG563127@unreal>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 38370f15-c254-4ccd-a894-08df18a8a07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8NVeu638W8+9OCrWDx3tmNINCTcL2ol3s1WcvstGhHXGeAnvn4OtZRIyAggKcsQUoD5mjN0B7M8iWN981lXqmVpmzUUOK2bdyoEPVaoCbN0XFpUUa6vM6fyu6PtyC6Wini/pejqI0Hw6C+fP10z5wq2aAIMDv5xOKzXfsWdo89dJ48KaeOBQkW1P0r6tZG9GjY/FbVB2bzUKYjTVPOa7HY5Hn/IdV0EgP+y1RzyC4M+oBOot6suUfpLLLShSxKGN5lC+CG3gW45Hmzkedgb4yC2sCYmZgOvg3b8O/WnZW1e6bbNvry/Ea52W3ajAPz65T5zmg/XywTG5hKJd5KaqKCHCCoEN1n+Fo6aGLAvlpnlRNyWk4RKqagqBOamBZwXUMymwJw4FHlULSFX/X1MxsxI76VZDy6lFy9MjyXbmqqh3HllI/qUBc52rbABN2++TM4v5xuCIA/uxvv8J2jZ/nFuG7EZHLo27o1eBPFbfKQ30qPUuxKp4uelF3X32WrUwX+jVmwWDyMFsS01OeMzH5P6JfABVrZI8dWrUuNXVRB7eCtKavEcYE3mKbOQSNtME0H4OZJKvLqMhy4+/7gxL1uXHNJeWPjECdIpubW6I/+dcAZVlpAnjcRTDpjHx3a1rDqo0D2Ee+Z5z4dgSGVOf4rbsKcYBwbdj1OFzDhrdW0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hHN2hoL2svL0xOaGhuSnMxMHE1VDY3eTZQZHFsTnJ3Z1MyT0Q4SStrK0g1?=
 =?utf-8?B?cHJ3RU1qNllTa2UrUEkrakl1aFJrUEhVTE15U1FxbStLcVJzSm1UOURUeGR4?=
 =?utf-8?B?ZmJVYzgrdnhLMGd2ZVpEMFIwZTNaWnAxSWI1a0pBZitYOVVWWTVrS05xT3Jn?=
 =?utf-8?B?MnEwQUxBUFZsOTQyZ2ZXZ0pGUDFoUWhTWEN1R0V0TzJvQjVKZ09KWHBjWDlL?=
 =?utf-8?B?TVVPaDZzdjU3clZLNjdJbCtkN01SUjVSM1F1eVMvWlE4NENEOVRrRXlVZm1i?=
 =?utf-8?B?R2dsQ3VBZ2xYbHpOcDR6a3Z4QWJMU0JPL29QaFpMRitSOVNYMksrSGN4dkNP?=
 =?utf-8?B?VUR3dlM4aGNVbUxCU0Y5QmJOUDlUeTdhaTIweHIwQ09WL2lQZVh0MWxuNStk?=
 =?utf-8?B?cU0rMkZRQVFjTzc2a3ZvYWhSb3FySkJRYWx3cjdQNlc0VzVHMG1EczFFaHhr?=
 =?utf-8?B?MzR2MUdyNXlRWVFpMUZQV0hzeXpFb2crNFJFMkdGRzBuMEdqWStCVFh2UmV5?=
 =?utf-8?B?SjBJaUpqSEs3L1J5U3NKdzY2TjhjL2JUT0JuSE9HS3N1by92OFcvYTNLY2lC?=
 =?utf-8?B?cC9mWTBFYXlnY1lINjVaaVpTOHRLTG0xSFcwRSt3V3FHd3hpS2s2YXRhTEFT?=
 =?utf-8?B?Uk0wMkEyM0ZzbXpUakVTVVU2RHJSTmJ4blMzTytWTDFKQXB4eXB0dTVYaCtG?=
 =?utf-8?B?V0x3LzE1TVBaTjl5d1YyZ2lqSWFjbHV0aFNheVJxSUIxUzN1REdORmZkQkJX?=
 =?utf-8?B?THkxSkZqR1AvLzNxUFVTd01pM1EvcDQyTTR2TGZuQTBWTjh5dmJsdVdDa2NW?=
 =?utf-8?B?TENGVkZkaDBlSG55TDBDRGhaVUh3ZHNwamsvdUNsVVBqNVVvZ2hsYjRtNFBu?=
 =?utf-8?B?eE8zVjM1U0JBKzI2M0pZSjRHd1ozR3NUbDExRW8xdDlhQ2h5dkVOeVRCY3JL?=
 =?utf-8?B?Sjh4eWRjOXVNRUt3d2F5M3FrODlBanhLNjFFcHNWcVd3T0FWRmsyQzh5VW1C?=
 =?utf-8?B?SVVpQlQwRWhmWHl5MUdoaktDL3VIL3JxVDBLbUhpWk1vdTJHYkF1ZFN4WGZH?=
 =?utf-8?B?M1VMMWRzSGF2Ym8zaWFQR3VLQU9tNUFhaG0yb0N4RGVCOGZwSWJEbzhZMDJu?=
 =?utf-8?B?bVdtL0NnZ3JXWXZzNWRldk5YMHMwVVpFZWxTM3VZSTlkeGJqb2FwcmJJMXlq?=
 =?utf-8?B?OXY0THFER0ordmxuZ0k4ZVVwUStkMzNpNzMyTVYxS0h5N0tRdjB2enh0RnVM?=
 =?utf-8?B?T3F5eDQzNEVHbDNNRjdXV24ybUZRVXp6dzlHZUJFck5vYkF4eHNtQmJKN0Zj?=
 =?utf-8?B?cDlONUl0dVpDMjZZem9WQkl2aGtYZUswUjBqSVhYZ3VtTVY0dkVDTEN0a01q?=
 =?utf-8?B?QXVTMnFwR3VEQXp5OVY2OHN5enpKYnBCYzdZL0s4VkMxNzdGNzlxTXlVeHpo?=
 =?utf-8?B?UDMwMFRlYnBnQkdxaTlReWM0bEpBR2QxZmZSRHNzRnczWFNPeTBRRCtXa2Rh?=
 =?utf-8?B?Y0lYRmZJa01WWDRvRlk5OUplaFlzUDd4M0kyR05BNUI4K2FFRy9sUzhXVTJI?=
 =?utf-8?B?eVJkeWhzSGJVQzBud3V1VDg4eW5rMHNneFBVS1Q5QlRvK1IyaWRXdXg3RHhD?=
 =?utf-8?B?bkF1WXMrWm80cVdSN3NIYk9ONXc5YmpGSXM3VTFIdENXZTVzeFNtV21xODRl?=
 =?utf-8?B?akxpZVFjeWJaYUlVTk9QbXZKcGRkRUgzMGdndk1iclgybEk2M2NWbVJHM1p2?=
 =?utf-8?B?cGNDMUFyTVFEMTFNd3F0VEhlUERweDhPZEhiNjF6YXdldnZ3MWNSL3FYWHJi?=
 =?utf-8?B?Zk9ScDhGNGhMb2gxdUVBUnd6U1g1ajBpN0l5L3lYaGV4REVLZHRYZlZQajNN?=
 =?utf-8?B?NjRqaTlnZTRteTJETkxkYUNUeTFwVjNKakZZWUFxUnBQV1EycS9iOW9xSVRE?=
 =?utf-8?B?YjZ1dm12VGZTQ0hxcS9lZzJTU0xIZTZxM2dQR2Jyb1lMWHRsVDlqNEVVb3JW?=
 =?utf-8?B?ZHA5eHlxV29aN0cvM3RIYzVQbjZKamxwYVcvSlVLZWJYNXlEODg5a0xTSFFy?=
 =?utf-8?B?SHBtdGpYRnowbGR3ZUtlL21MZG9VcnlMaUlacm9LZVlBRStib040N0tlcDNP?=
 =?utf-8?B?YU9pcENqMy8wMGIzR3dWT2pQZG9wdmdYSHZTblF0a1NnL1lEZ0k4SFhOanlR?=
 =?utf-8?B?SUVoMnJwak9iZjl5UitKM0xVM0cxREFrcWMrR1NaVGtMdm5idnRMYjBxZnd2?=
 =?utf-8?B?NEs5ZmhxcldLMm9vZStZbkZMbGpSN2cvOFlpRy91eWtPOENtUkY3Wkl5QjJ4?=
 =?utf-8?Q?smxubeJJ80rielEZ20?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38370f15-c254-4ccd-a894-08df18a8a07c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 12:54:23.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RQAcQQIoJ029OBBPcOvE0X/Sr5cSycgwj5dgVPbq8G7sIgynbXQ/h6tnbywnjAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

On Tue, Sep 22, 2026 at 03:46:37PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 22, 2026 at 09:41:37AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 21, 2026 at 04:09:18PM +0200, Christian König wrote:
> > > >> I would avoid that and just re-create the DMA-buf fd from
> > > >> scratch. The extra overhead is negligible and one way state
> > > >> transmissions are usually much easier to handle.
> > > > 
> > > > Yeah, maybe we should have done that. Might be too late now.
> > > 
> > > It's already uAPI? 
> > 
> > Yeah, but Matt is making some changes here so maybe new stuff can
> > avoid this. I'm not sure.
> 
> Jason, the proposed semantics is not UAPI yet.

What I'm talking about is, the revoke/unrevoke flow for a single FD
was added from the start. For example vfio_pci_ioctl_reset() does it:

+       vfio_pci_dma_buf_move(vdev, true);
        ret = pci_try_reset_function(vdev->pdev);
+       if (__vfio_pci_memory_enabled(vdev))
+               vfio_pci_dma_buf_move(vdev, false);
        up_write(&vdev->memory_lock);

The false restores the exsting dmabuf fds back to normal operation.

Matt's version is one that defeates the above false so once revoked it
stays revoked forever.

Jason
