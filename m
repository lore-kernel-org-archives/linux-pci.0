Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56189 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcBHQoP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 11:44:15 -0500
Subject: Re: [PATCH] link up validation moved to pcie-designware
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com>
 <20160208164104.GA17268@localhost>
CC: <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CARLOS.PALMINHA@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B8C5B5.5050400@synopsys.com>
Date: Mon, 8 Feb 2016 16:43:33 +0000
MIME-Version: 1.0
In-Reply-To: <20160208164104.GA17268@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
Ok, so what should be the retries and waiting time in your opinion?
The most typical is:

retries: 10
delay: 100ms (usleep_range (90000, 100000))

These values should be ok?

I am already testing a full pcie-designware platform driver.

Joao

On 2/8/2016 4:41 PM, Bjorn Helgaas wrote:
> On Mon, Feb 08, 2016 at 12:43:58PM +0000, Joao Pinto wrote:
>> This patch goal is to centralize in pcie-designware the link up
>> validation. A new function was added to pci-designware that is
>> responsible for doing such a task. This was implemented in a form that
>> permits flexibility for all SoCs.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>>  drivers/pci/host/pci-dra7xx.c      | 11 +++--------
>>  drivers/pci/host/pci-exynos.c      | 11 ++---------
>>  drivers/pci/host/pci-imx6.c        | 11 +++--------
>>  drivers/pci/host/pcie-designware.c | 20 ++++++++++++++++++++
>>  drivers/pci/host/pcie-designware.h |  2 ++
>>  drivers/pci/host/pcie-spear13xx.c  | 12 ++----------
>>  6 files changed, 32 insertions(+), 35 deletions(-)
> 
>> +int dw_pcie_check_link_is_up(struct pcie_port *pp, int max_ret, int sleep_min,
>> +								int sleep_max)
> 
> I think "dw_pcie_wait_for_link()" would be a more descriptive name.
> 
> I doubt that the variations between drivers in number of retries and
> amount of time to wait are meaningful.  I suspect most of those
> numbers are made up or copied from other drivers.  So we might not
> need the max_ret, sleep_min, and sleep_max parameters at all.
> 
> Even if there really are important differences, I suspect the only
> important thing is the total time we're prepared to wait, and we can
> leave it up to dw_pcie_wait_for_link() to decide how to split that up
> into sleep ranges and retries.
> 
>> +{
>> +	int retries;
>> +
>> +	/* check if the link is up or not */
>> +	for (retries = 0; retries < max_ret; retries++) {
>> +		if (dw_pcie_link_up(pp)) {
>> +			dev_info(pp->dev, "link up\n");
>> +			return 0;
>> +		}
>> +		usleep_range(sleep_min, sleep_max);
>> +	}
>> +
>> +	dev_err(pp->dev, "phy link never came up\n");
>> +
>> +	return 1;
>> +}

