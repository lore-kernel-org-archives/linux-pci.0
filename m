Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A75C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3D2084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jhVmnFF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfDLF76 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:59:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12959 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLF76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 01:59:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb0294c0000>; Thu, 11 Apr 2019 22:59:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 22:59:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 22:59:57 -0700
Received: from [10.24.70.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 05:59:51 +0000
Subject: Re: [PATCH 12/30] PCI: tegra: Add SW fixup for RAW violations
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-13-mmaddireddy@nvidia.com>
 <20190411200121.GQ256045@google.com>
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f0f02fbd-0217-9c6d-437f-e5212b67bc24@nvidia.com>
Date:   Fri, 12 Apr 2019 11:29:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411200121.GQ256045@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555048780; bh=qbhLQh7gx5hCXW09N+4LUIGjDIxn461MyCJugsvImAk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=jhVmnFF0S8kPCz+gtt9dZRXhTGYz8/39KG1CnxpuKlqsLoVC+M18zI+Szl2Pt+8/v
         BE/p36bKxg3XJhR6gQuy0m/wHiNpEgazFIEhaCkSkQO1JrLzFPss8+Pf8XItbYzhOe
         gOvWWZLoEaVbzfBfe4zNexwK7SLgoAo94tbQK/CEP/7/xn4td9KFIDbSQMjlKMH5oA
         r/hABmfuIBnc/3eJe6c9V7NZxnKuThdubYUP/Y7JQA5NqHeWY/+ih14zwMM8hgh7mN
         N4VNds64bYqf3/VmDFdEvuMdioerynv0i1OJicL3xBzJn6eK1FZyp0GQORHK50DuKV
         hh4Nvqz22KRGQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 1:31 AM, Bjorn Helgaas wrote:
> On Thu, Apr 11, 2019 at 10:33:37PM +0530, Manikanta Maddireddy wrote:
>> The logic which blocks read requests till AFI gets ACK for all outstanding
>> MC writes does not behave correctly when number of outstanding write
>> becomes more than 32 in Tegra124 and 132.
>>
>> SW fixup to prevent this issue is to limit outstanding posted writes and
>> tweak updateFC timer threshold.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>> @@ -2381,6 +2408,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = false,
>>  	.program_deskew_time = false,
>> +	.raw_violation_fixup = false,
>>  	.ectl.enable = false,
> It doesn't really matter either way, but you don't *have* to
> initialize all these flags to "false" since that's the default for
> uninitialized fields in static structs like these.  If you left them
> out, the structs would only contain the "true" items, and it'd be
> easier to see what's special about each SoC.

SoC flags are explicitly set false if not supported, I am following same existing

coding style in this driver. Maybe the intention here is to convey what is

not supported by a particular SoC without going through soc struct definition.

>>  };
>>  
>> @@ -2407,6 +2435,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = false,
>>  	.program_deskew_time = false,
>> +	.raw_violation_fixup = false,
>>  	.ectl.enable = false,
>>  };
