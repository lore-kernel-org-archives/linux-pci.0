Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] link up validation moved to pcie-designware
To: Arnd Bergmann <arnd@arndb.de>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com>
 <20160208164104.GA17268@localhost> <56B8C5B5.5050400@synopsys.com>
 <2817924.61jZWIvqjt@wuerfel>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CARLOS.PALMINHA@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B8C6C7.9060105@synopsys.com>
Date: Mon, 8 Feb 2016 16:48:07 +0000
MIME-Version: 1.0
In-Reply-To: <2817924.61jZWIvqjt@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Our

On 2/8/2016 4:46 PM, Arnd Bergmann wrote:
> On Monday 08 February 2016 16:43:33 Joao Pinto wrote:
>> Hi,
>> Ok, so what should be the retries and waiting time in your opinion?
>> The most typical is:
>>
>> retries: 10
>> delay: 100ms (usleep_range (90000, 100000))
>>
>> These values should be ok?
>>
>> I am already testing a full pcie-designware platform driver.
>>
>>
> You are the one with the datasheet, not me. ;-)

Our reference driver follows the 10x with 100ms delay between retries, so lets
follow that value. Agree?

> 
> 	Arnd
> 

Joao
