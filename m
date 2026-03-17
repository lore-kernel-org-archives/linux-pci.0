Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BF359A82;
	Tue, 17 Mar 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738847; cv=fail; b=OBaospc1bZdOUMjW18AfEY3dQtoxEtcrAi6bB/3un65Cd9jv0bIsM/l9qKoD/R5tCvoDWPwO467EiLP1C2/gtUherItylaSGvwT1MM9NT/FIBOD4JPWwJYcumr9rC9hBj/flUj/idngkydBALVwzOw8KkGl1YoeSBVDhDrfnO3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738847; c=relaxed/simple;
	bh=avjNG86B1YT7LqX6IQ169dpbH8vP4Xck5sxO2mJ1zms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BoDfWrfruOLWRPX1tC2U8j8o18TatqP6r07rf1fETFNQ3w/VUz13LKrlx62/fano2hH3Z+xpUqFjnJlr2NB2rytDl322PGA93hB4VXcEwbU4fU3ZZI1p0QtNCVu91+oIezQcedYxjg22VbOXa1TDu3iRin3qGJ0XUTo2fQpyn14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ogXbuX9C; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ogXbuX9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgCFKkBUO9rb7q3Aq+P7N9020R1/s2D9ELw1sgHL1q0Lo7AomFty74bZJevXwyly6CKZbn1/MnBtYRWDaIjJwNxCHSn2g3fykbztq5sfIedOPwFvtyjih82yR5F6JGL3GxqWxJIypy9FEfFP3PX8xGN3cqe8OjLyZ6FmYZa9u6dBLtFvcszwRD1COct9FSpubKtZ8inH62Q0ZQeA4Dx9Xo8Rh/5sw/Vi67Al8RY2ybwd/IblYsLiER5U+P+3CqN5OuG7NS74AHZ+5lUJmgz1i7l1tXXNQAkv966xOG5jZwR/YlqWx/I703z5/csuvWmwWqOqs97YWXwnERxqTK2+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDrJ7SHntfnz0geLpIUQRGSC6JezHe/gpkHJFyyUDAs=;
 b=ncdhVdyYAPqsQuuG+NNWjJSOPCmpBD340BuKW7utpsy6QmP/wLZ8cxOeJW5S43+99DM7IX/b4XgDX2H08PYXg9hz2dVLcYEdHwY247iNOoaIPxgSHLIWievis4ZSDTPKs9sYr2Wz07MrKkDLCHAmqE8ioh1gdtCDbBFAM1pNbq1taaY96sMRK2zynhMt1GoE2Fl1NYFFmuC7ibx9lebcHOStYnm1GoW0ANSS1qZ4UqVcQELt8CQFYvSrgJVkuex8Qf/PmIg5zev8edXn2QTbLIlA0ZgtAVI9276JyTTu1JommrpZ5rQ55o0HyJUwMs0RKiMdB1rXYH8LnujhZTYCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDrJ7SHntfnz0geLpIUQRGSC6JezHe/gpkHJFyyUDAs=;
 b=ogXbuX9CmkYzvrGLiOEG+BiUOX88wI5qVGpZ8v89a7ouV6iFg/KIvtwGQilb6PrC2jRti31TG1zVH2p1fDPGmwqi1Wtp9mcBYQIR65i7oUCRJ/Af+4M2CFjxfBjuMOIbpQXLUsPyaqmlTHJklrDlr16ZQGznswDQBuaPNbohM3mCActLa5MoxvCiP7Eg8YV5FthTC00NagKn8faELEeZ+xEg4G78J7YNu9bxNEjgPOrt3hXdpZamStHJQDVOjB5VMfXYYJ0D58nt0LodJbfT72wZJvB5qFJkjOderFdUyabeeymz7T73H6Z1StycBpzKlF6HkPKsngz8460lJrHOhw==
Received: from AS8PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:20b:31e::33)
 by AMBPR10MB9901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:761::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:14:01 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e:cafe::31) by AS8PR04CA0118.outlook.office365.com
 (2603:10a6:20b:31e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 09:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 09:14:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 10:16:18 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 10:13:59 +0100
Message-ID: <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
Date: Tue, 17 Mar 2026 10:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
To: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	"Bjorn Helgaas" <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
CC: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon
 Vijay Abraham I" <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook
	<kees@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|AMBPR10MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 28250208-d714-4ca2-6e86-08de84058751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wo92EcDsbSuF5Fula56BVslSGNanZIczuibr3g3i7R9qAwXeU6S5nMCfM+AaySs/y9UuO0INaX/V6JcDfSoeA0N6YK2pKVPU3vBKyIyLQt5Rb7tnj362YoDocvud44vloL+cpDpMVecF2hdngTtEm55DQvGSRDA0k6brD7tvxaeTzbXXP2qdyV5P3/N7zoWErKDK0KxoUUe3DlvayaBqbuE6mAAUmHzFZSVpaVY50/GllBwR3HM8h9rT8mIKsPL3Ig/0XNbvUIkWG4LTS6/v/sMQP8E7P1QybpMKTG2Ajl2+hbDQQ7CVB80o2WaxsMVX9lDgufUIXQ9MxNqjQr/s94ThT+gvmDmuqHDj8dTbxDLhr0f10NuCr/t7ZncTRfcx4/9YaWNrnHgSfmapNQpJXhRr3DsElIVPnCk6V9CjSiFc5a9llA3GLkVLj+x3lbMZ0A+VDlTFpdvqw8S9dfzrNpWuJIp+pFM7o4dnlfdXlG5WGjpLtlrE8BW+H27kpKRGHLWioSzpDhxscI1/EV9nRHcbbI4vJsTvHO5Zwxk2acjnUnbSJpn+etK5muQ/7qjr/8/vTe1G6LI1BHv1CFPZ+9LwlkQPFPHv9CnebQgD1HvJNckoel+MLY+JhC0kMTiaVQfsz6ShGTii8p9ROsTkcLVy9msIP/yvJHRX3tVXiWCGiiODEEN2dcKRHOXRMc7weaj/PI5kvK5EV6+jNEXA1AIDZf7Wpaccf82iMhqmJyP7FQjMz7z0N9fo+FXfV42Y8V/cndtAasa0RUtJelsPZcndD38hpWT139gE4d9O2a8=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R8MlhAvE6lNvHmUxeJHSMV7/U3IK0qtepPw6ytVHjcNttpoY6V9Q+9jwoZusNmRE/kv/sRbPwo14oPG/T+FxkTh4ZXlDQJeDnSyHESCENjwdxEZXsXmT5HdXTalbBhmywsTAXDSUifmHMS4as5Etcmhm6BsySOm7KlQhSvFIA/E/1NfQ4UFYJmm4hvgJq3J58w0jrlKVxhtG7L1TdFPcUfEDAPw7+TdTd6GQdnBp+sL2O+gvqLoNYn16mmGU7Om4whdm82egdKAsLwWBL3uXciTnF6CyuCvDMPnsxrsHz+G9BNJergNTMasZ33mTDB6XEcj5EYleBHNIVQo2EOg1NN1xhlKofwa7ZjU6QDQJSDlacgKUeajMrUxrxlCGVciIeVUAPaEU4HTuRBb02EhKVanL4ILIOHrPZCdvnvolnC2Ngd8YVPOxCyYWMQPA+ig5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:14:01.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28250208-d714-4ca2-6e86-08de84058751
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9901



On 3/17/26 03:57, Koichiro Den wrote:
> On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
>> On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
>>> When the BAR subrange mapping test on DWC-based platforms fails due to
>>> insufficient free inbound iATU regions,
>>> pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
>>> not restore the original BAR mapping. This causes subsequent test runs
>>> to become confusing, since the failure may leave room for the next
>>> subrange mapping test to pass.
>>>
>>> Fix this by restoring the original BAR mapping when preparation of the
>>> subrange mapping fails, so that no side effect remains regardless of the
>>> test success or failure.
>>>
>>> Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
>>> Reported-by: Christian Bruel <christian.bruel@foss.st.com>
>>> Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>> ---
>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index 14e61ebe1f11..f44c36f5cac5 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>>>   	bar->submap = submap;
>>>   	bar->num_submap = nsub;
>>>   
>>>   	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>>>   	if (ret) {
>>>   		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
>>>   		bar->submap = old_submap;
>>>   		bar->num_submap = old_nsub;
>>> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>>> +		if (ret)
>>> +			dev_warn(&epf->dev,
>>> +				 "failed to restore the original BAR mapping: %d\n",
>>
>> Nit:
>> I would use a capitalized F:
>> "Failed to restore ..."
>>
>> in order to match most other prints in this file.
> 
> Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
> when applying, to avoid a respin for such a minor change.
> 
>>
>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> Thanks again for reviewing, Niklas.
> 
> Christian, if possible, it would be very helpful if you could take a look or
> test this slightly polished version and add a Tested-by or Reviewed-by.

Tested-by: Christian Bruel <christian.bruel@foss.st.com>

with the DISABLE BAR dependency
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9

I will need to update the pci_epc_features after the merge.

A more general question: I don't understand why only the STM32 is 
impacted. It seems that all targets, even those with 6 IB iATU entries, 
should ensure that one BAR is disabled to handle subranges.

In other words, will there always be at least one BAR_TEST BAR variant 
that is skipped for all platforms, or am I missing something here?

thank you

Christian


> 
> Best regards,
> Koichiro

