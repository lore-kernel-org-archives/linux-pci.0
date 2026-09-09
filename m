Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF8582B81;
	Wed,  9 Sep 2026 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985936; cv=fail; b=aYF4BfbRpqcnfxPYGZ2xqDbAkZNAJV6IK5yv5ao9KDGLn4Ad0OH5jXAjdaOAxE4n9W3IaybvxxmUYBTaoEUgi4uVWQHmNW67YPjV7wyjyShBS5DZxVBQKqs6U+NoXz8F5iShlKI0e3Hu5cRf5QaiiqXa3zSwAdRPrIiKg9ddn7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985936; c=relaxed/simple;
	bh=eMrAiRsXpIF+vf98KwEEkdYAAINQFpNPXvL9c3bNyQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jtf0Ljkw/sVqcUK9TRTMt/SKVUiqpz2nYrnamNMwIdmF0Nlc7CFMF30LNClnTHDm4BILKef/hnb063s/ZRHD8KsrHmjpEbmcwUZOX8l4WMYCkYyBcX2LQTQ/QZuiXlps2Ky/H0CHRce8hdRFYnU0MI9EB2ZJ6l//5TNj9LSbgRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VwL9AZK; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VwL9AZK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKqt3Z3QFwpRnGWkx3JaIKZVpVMYfrbcQpBvXnA7AnAGJ4muNobpzfs1n4LJSMojNfArRklRYTiAQruELXlcJRj3JMdZFrBtzj+zGrp5Em4r1hE5EwC/Wd4LkcdsAM0KDX28e7/oR+2W7jLxZ9HtKQ3FQrlZGx+St/PPRfuat+r6yyuiMQue4LsgV/u6rSudlWlEZbOxcNCOr7lsCK1gZv+/vK+fqe2MidN36YuUbkHZWKy/4hm+GcBTZEDgdeIlqzFwRofoUh6ll7udyelPmTlABr+1zNMUoPLqfKCSjeJoimDcIxK8BhzxW0nZazhi8B9fsfGMZRcx/3E+4IDE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q13vHLtIHjvLKM4hfnSoeTQJlSiI5db/IruNRrHI1s0=;
 b=ZLEWeDQL7m9VgRu34xr0+aRYazgWWh6rhgfQygOyy4kkMGDAO3Xy7sYkX+cLNmQK+wN0m1nKr9zdCktwCQ5JFgQsXrC5jXOCrmmBJ6MBvd/d3HOn1iUnECWgPdKfn/YLyaiptK6kVls32Ln3BuwlJtz/57VRX4deIaCLR/MX9zXr3nDpZVuaqsE+xkEOPugMkdmxjLMnByyj/WHFtPocQ13GXTT5pZWo0rK+lNNFmtTYi6XXZTjyOsSQjgA6tKq+lmQo91PjwslAJ+C/LpyDxRu0i/VfpWHls9Hk5wMyCNv09v1BTOFk4oZV06/q4/VriKbLp2i0cVQ9dZ7cs03NGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q13vHLtIHjvLKM4hfnSoeTQJlSiI5db/IruNRrHI1s0=;
 b=2VwL9AZKP+CrW725RBfiXVAj5/mO8Nsn/Hungk+mZFQdmHwCve0QEJ/lEVP4OgYLcoED5ds2CmJp6rQzGiqyf85qVauH4Ii3pFdMEsCH6yNW5eb6/4P9P0OQ5ZAnWHBAHvoiNizcW+vLVmx7ubwxGXH0MSWfjHrpjbDIpKoHD6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 20:31:59 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 20:31:59 +0000
Message-ID: <c6b62614-fcc8-48aa-b65e-b3c26c8579a7@amd.com>
Date: Wed, 9 Sep 2026 15:31:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 0/9] Enable CXL PCIe Port Protocol Error handling and
 logging
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <aqGDV2GQEqxg_1gE@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aqGDV2GQEqxg_1gE@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:510:5::34) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: b4448ab4-38c3-40f6-a6cc-08df0eb165df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|5023799004|11063799006|4143699003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ySj8dm9M79vjtralVTqG1jb73hNHPPJlS0C3Cjk9g1Fr+rVXEa5Qmydrw1t2gcz99AlkpOMVoXJzQ1IX2OugScLBdAm5S/bV7dzL7A7dIMvLZHpE2F4sabpwevqxt5gbgqjJX/xCig6jjkEsXzPc7mHc8J2tDWpPKGVqvAR3kgzqLXzLWEQ/Rt9pLk/NlICX0thBCBDkMXo5UfoJY5cJZ6+N09w1mE3co5hLggdgPew5nX7Ya4nbQj7qYrUAO2JyA3kfwHj5S+ludcla16nZ4sdrCD66x61wWINVjFO+it/Pff5PSTBloXpb4/0cSbu5hd3x+DSR96KnKQwWJBSmrNOwaugUW3PBFsCAKkKMm3wIYyciCP4F4RIcPu8UaTFBCNzDrU4JVKiO/eQJRw9/f2xVzz0W5B4QVMBg5QTnfGBAm2GDc+HRQP/bZ3hJESKtzkwQKAyR3g9EaHdeW+vzkgcRgXJZEn4jO++oezPaA2UxyXQls7AhSF3aMADjLbQTMW9awKRwljQMlrfL7oadMzN4rsjXcZllslM/Nzp1BoxmVuHcyQsgq6d/dgAzhzm5k65NycIDHMW+IEmVwxSBubAH/jibTNolUpltn4ng6j6hfS1865+xW5PB/eb8C9gADxIkl41/xb5Rd7FzWfYlgF0YoEi6qozIWn3qdF9kSwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVFaR0QvNmMyM2ZQcFp2QmpMRkYxcTUwemNaMVRHL0ttdGkzRU1od3BsY1dC?=
 =?utf-8?B?Z0pRQ0RWMUt6Q0pIREp5VW1SdmVvNVJZUllWL3lJT1NrNEtlUS8yS0I5MmZU?=
 =?utf-8?B?cmlpUVRFSyswK2VUMDNXbVNFbW1LRFd2ZVJhWnB2cjJMRDcvUVlMaUZvd2Vu?=
 =?utf-8?B?SXBRWG0rZ01HN05YdG1GeXpVdTRyaTl2ZS9RaDdxSHVaNk1iKzdpTlJVSzJ6?=
 =?utf-8?B?N1J5UkZ3RDU0SlVpbjZEN2Y0NTU3QnhXRExPQ3JrVlBWM2xQYlVOdjBSVFFx?=
 =?utf-8?B?bzJPN2VmcUw2RHh0TnJhNEdnK1ZxOHVlMmtUU25nQVVoWjI3cmpMa0xGajFw?=
 =?utf-8?B?R3dUdnRqR2N1NnJOcEdUWFdMMFNUVlZRSlVxZzlUOWdoQTd4YmkxalBlN1oy?=
 =?utf-8?B?L2hoVmFHcXdnRUZsK2kxS24rLzh0VFRYaVZjVUpROHFKQmVLakdOcktsekVo?=
 =?utf-8?B?bVU0Z2FKaWNOZkY5bFF3STFhdmtYWTkrcGdxdDJpamdpNEI2ejdvcXk2MERO?=
 =?utf-8?B?dXhCemhYVFdCVW1HYlh5b0h1UWtXbXB3eVJRY0JOa0ErN3gzbGE4c210WWg2?=
 =?utf-8?B?dlNnR3FpdzB5ZndKc25MdEljSzExYW5TTVlJY2g2dXRoUWxxQkQvOUhjdDBS?=
 =?utf-8?B?UTRkWEZ1eGNZNCtYc3lQcUlyM0U3bHR4MlpDWWFNMUVBZjd2cUk5MnJ5ZXRQ?=
 =?utf-8?B?eG5yR1ZPTW1rOE1LZGV6MkVkVncyKzRidVF6ZCtZRldaY3BjcjdkNmFEL2Zi?=
 =?utf-8?B?YmZ6UFZVS1VaREJhbkNETDgwMncwZ3hrTjk2bzc4aGpuQTMxci9ITW16WWRj?=
 =?utf-8?B?MEYzVCtiOW9FV1pueTlZSTlLamc0NkUyaVU0VmJ6L0VlKzFROXBLRkhwUzd3?=
 =?utf-8?B?NE9WcXhHSlVBTWh6b2tpc1VaRHNjZ0M5REd2SExnUjIxeFRIUGlFbmFGTXRm?=
 =?utf-8?B?ZkthZ2gzNkJBc2REcFpoTm9Nak5hVWdiMGUxOGRBQlNVNFJvRzFuN0lacDhY?=
 =?utf-8?B?bDZXenlDcjlFeGVDaHc3RmlSTTZjcy83bzZXWmMxcytkRXF5Vjh5NEZiRFZ3?=
 =?utf-8?B?eENuTkQ0OHg4Q05XY3E0TkNFNmRqY04rY0duSC9RWWVhcG5kSGVDMXJPZGVk?=
 =?utf-8?B?U2VkNituaFRZaDNUdmNVTThPWXhxUFhYWkxVRUNHZmQ2V2ZpVy9WTTFhdkJa?=
 =?utf-8?B?ZmZTWTZEUDBrclVsRmJ5ekkzV2drWkkrbzhvbDJlTTEwbWRVbTViQUZtUHBX?=
 =?utf-8?B?UmE3MitYRzRVaVJVODJGVVh4ekt0bFZ3MzdZS1hnTmZFdlkvd2FzNm0vZUdE?=
 =?utf-8?B?Q2pLa1gxai91S0x1NWlnMlNyVysrQ0NJend3NFdUcmpFUFRJNEFyYnIrbW5t?=
 =?utf-8?B?c1JUS1k0Ny9BdjVRM1lzTU0yMFM0c2RxY2lSTXp1bXVwRjF2V0NRWXBSTlF1?=
 =?utf-8?B?VXlkcS9PaFBLTHIyRDFENTRldzdnZU13REwyeDFqWllLcTFzMklRS1d5NVND?=
 =?utf-8?B?dFRnakFVRWtMVDBXaml0MTNCcWFLY2FYN0ZUM2xyYXl0cU9saERsS0h1STAr?=
 =?utf-8?B?N1BJVHFQOS93TFpTclFVSmJqNitTdldkaVNNWnk3ZU5OYWU3YXBhR1FicEtH?=
 =?utf-8?B?cU45UFJocDgveW5yUkhBS2YzdmI1cC8xeDNjVFg2NFBOWDlCT0R6bzJCMWpN?=
 =?utf-8?B?ejhUbVovN2cyRXMrNHRhUmgxR1UvQXZ4dUxYWXBHaDQ3dUM0VFdBNnBib25z?=
 =?utf-8?B?QmZrZnBYS1JrVTV0S3FPRStOa1N0YTBQZDJCSENqaDJJU1gzZVJHbnV4VWFn?=
 =?utf-8?B?bDRPOFdFWFpyYVI3SUtpU2lDQW1QbGR4WjBRclBwVXVCU0p6R2Ywam15SURt?=
 =?utf-8?B?VGFzVzZjVzVsS2plb0l0WVpxSm54L3ZVaDlmZjhaMGJPWk8vWDRlOXl0Z3Vw?=
 =?utf-8?B?aHJRUzY3UmdZVnNrbWtxK3hMR1dnQkpJUDhDZU1RdUlXZUN3WnZmMDRsa2dz?=
 =?utf-8?B?UzQ4YTF3VGdXTDliM0g4aHpqZGVHNHE0dGQvenk5OWJINkl4THpTVU5xQjhB?=
 =?utf-8?B?QUVDSElWNzdKVXBTV1A2ZFNXcW9yQTlNS1A0dUJHUkt6cDk2aXdXU0dKUGxu?=
 =?utf-8?B?YzMvZjhLM0hTWURUbWcvVm11UFZsczZGRUxkT2ZCemV1TWdjSFJhd3ZJcS9a?=
 =?utf-8?B?MmJqNjBBTmErWkFmK1k2QnZOekJXcUhPYVNBdnl1bk52MXJmTjY5aVFLR1Qw?=
 =?utf-8?B?Z0tzdWVOKzI5RUt0UEI1Vjgwd0QzSERqTjdZNFRGYUFtVlhSN01wd0VIczZD?=
 =?utf-8?Q?4oPMZBcgIz6QDDWFbj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4448ab4-38c3-40f6-a6cc-08df0eb165df
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:31:59.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrwpu9VZfQHwfPFxykp72HYwd4IzKVx6vygAIBrT8JC++xJL+C16tdJ9nA2za6k/QG1zNLZqkqCVWwH8rzNPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

On 9/9/2026 11:03 AM, Lukas Wunner wrote:
> On Wed, Sep 02, 2026 at 08:39:24AM -0500, Terry Bowman wrote:
>> Today the kernel handles native CXL.cachemem RAS only for Endpoints and
>> Restricted CXL Host (RCH) Downstream Ports. Root Ports, Upstream Switch
>> Ports, and Downstream Switch Ports are uncovered. This series introduces
>> a unified CXL protocol error path for all CXL device types, in both VH
>> and RCH topologies.
> 
> I'm trying to make sense of the existing code.  I know this wasn't
> introduced by you (but by Robert in 0a867568bb0d), but you've moved
> this code around recently and are extending it in this series.
> 
> Errors of the RCH downstream port are signaled as internal errors
> of an RCEC on the root bus.  Their handling was plumbed into:
> 
> aer_process_err_devices()
>   handle_error_source()
>     cxl_rch_handle_error()
> 

cxl_rch_handle_error() is used in the RCH and RCD error handling path. VH errors 
are handled through the call to cxl_forward_errors(). Both, RCH/RCD and VH errors
use the kfifo for handling in cxl_core.

> First of all, handle_error_source() calls pci_aer_handle_error(),
> which (for Fatal Errors) will issue an FLR of the RCEC.  Note that
> Uncorrectable Internal Errors have Fatal severity by default
> (PCIe r7.0 sec 7.8.4.4).
> 
> If the Uncorrectable Internal Error was the only error, then why is the
> RCEC being reset?  It's just serving as a conduit to inform that there
> are CXL errors at the downstream port.  There's no reason at all to
> issue an FLR to the RCEC in that case.
> 

RCEC FLR doesn't serve a purpose here. This likely needs a check to skip the FLR
if the device is a CXL RCEC and the error is internal, indicating a CXL RAS error
at the downstream CXL device.

> Second, cxl_rch_handle_error() then walks all the RCiEPs reporting to
> the RCEC.  This also looks weird to me.  Can there ever be more than
> one RCiEP?  I think not, but maybe I'm missing something.  If there's
> only ever a single RCiEP reporting to the RCEC, why perform a walk?
> 

The RCEC can have more than one associated RCiEP. The associated set is carried 
in the RCEC Endpoint Association DVSEC, which is what pcie_walk_rcec() iterates. 

> What we actually want to do is retrieve the CXL errors from the
> downstream port's RCRB, but this is done in a fairly roundabout way:
> cxl_rch_handle_error() walks the RCiEPs (aka RCDs), invokes the
> ->error_detected() callback for each, which is cxl_error_detected().
> That will then call cxl_handle_rdport_errors() to find the RCH
> downstream port to which the RCD is attached.
> 
> Isn't there a simpler way to find the RCH downstream port from which
> the error originated?  Why do we have to go through the RCDs?
> 

Unfortunately there isn't a better approach. The CXL spec (Chapter 12) outlines 
2 procedures for RCH/RCD protocol error reporting. The standard approach is 
implemented and follows the logic of searching all CXL RCiEP's (RCDs) 
associated with the reporting RCEC.

A second approach defined by the CXL spec named the RCEC Downstream Port 
Association Structure (RDPAS) was submitted for review by Dave Jiang but did 
not offer obvious improvement as it didn't eliminate the search iterations.
Also, its an optionally supported platform device hardware making it "not 
required". 
https://lore.kernel.org/linux-cxl/20260618170723.2010490-1-dave.jiang@intel.com/

> Also, putting this in cxl_error_detected() has a weird side effect:
> The function is also invoked when the RCD upstream port experienced
> an error.  But because the retrieval, reporting and handling of
> RCH downstream port errors was put into this function, those errors
> are reported and handled as a side effect of RCD upstream port errors.
> What sense does this make?
> 

The side effect stems from the RCH Downstream Port being implemented as 
an RCRB with no BDF or PCI visibility. Because the DP cannot be addressed 
directly, software discovers it via the downstream RCD.

Per CXL r4.0 §12.2.1.1, an RCH Downstream Port has no BDF of its own.
The RCEC Error Source Identification register logs the RCEC's own BDF 
"because the RCH Downstream Port is not associated with one," and the 
spec states outright that "the RCEC Error Source Identification register 
is insufficient for identifying the error source." Software must therefore 
either follow PCIe rules to inspect the RCEC-associated RCiEPs, or use 
the optional RDPAS structure (§9.18.1.5) "if present." Because RDPAS is 
optional, the RCiEP walk is the baseline discovery path, and it is why 
the DP is reached via its associated RCD rather than addressed directly.


> The commit message of 0a867568bb0d provides the following hint as
> to why this approach was chosen:
> 
>     The reason for choosing this implementation is that the AER service
>     driver claims the RCEC device, but does not allow it to register a
>     custom specific handler to support CXL. Connecting the RCEC hard-wired
>     with a CXL handler does not work, as the CXL subsystem might not be
>     present all the time.
> 
> So I think the point may have been to make this work even if the cxl
> module is not loaded?  Is that all?  Is that the only reason?
> We have try_module_get() and symbol_get() helpers.  You could just
> call those prior to invoking functions implemented by the cxl module
> from the AER driver.  There's plenty of precedent for that in the kernel.
> 

We we were looking for a callback that fit the current PCI error handling
but also supported handling errors detected in the RCH RCRB. The move
to use the kfifo removes the module dependency and timing constraint.
I'd prefer that over symbol_get()/try_module_get() here: it avoids a 
per-error symbol lookup in the error path and gives explicit ordering against 
AER recovery via cxl_proto_err_wait_for_empty(). But, I'm open to it if you 
see a concrete advantage.

> The problem is that the present approach is fairly complex and has
> side effects which make it difficult to understand and reason about
> the error handling.  In my view, this should be cleaned up first
> before bolting more functionality on top of it.
> 
> Thanks,
> 
> Lukas


I understand the concern. The RCEC-reset-on-conduit-error issue is
self-contained and worth fixing. I'll post it as a standalone patch.
                                                                                                                                                        
For the broader restructuring, this is already on the serie's coversheet TODO 
list ("Move RCH traversing for handling from AER driver into CXL driver"): the 
plan is to move the RCH/RCD searching into cxl_core, after the error is forwarded 
via the kfifo, so discovery lives in the CXL subsystem rather than the AER driver. 
I'd like to keep this series focused on landing the unified CXL protocol-error 
path and take that up as follow-up work. Is that acceptable, or is there a 
specific change you'd want to see land first?

Thanks,
Terry

