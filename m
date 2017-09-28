Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [RFC 2/3] module: Ignore delete_id parameter
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Dan J Williams <dan.j.williams@intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-3-git-send-email-jonathan.derrick@intel.com>
 <20170928090234.GB12599@kroah.com>
Message-ID: <c9b6b6d0-27bb-1d37-da34-06ecc714bbc4@intel.com>
Date: Thu, 28 Sep 2017 09:57:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170928090234.GB12599@kroah.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 09/28/2017 03:02 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 27, 2017 at 04:40:21PM -0400, Jon Derrick wrote:
>> The PCI driver delete_id parameter is handled in each individual driver
>> registration callback.
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  kernel/module.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index de66ec8..2b2dccf 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3620,6 +3620,13 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * Ignore driver delete list arguments. They are handled by driver
>> +	 * registration callbacks
>> +	 */
>> +	if (strcmp(param, "delete_id") == 0)
>> +		return 0;
> 
> Why?  This is only for the PCI core as you have defined it in this
> patchset, but you just broke this module id for all other kernel modules
> in the system :(
> 
> If you want to do this, you need to provide this feature for _all_
> kernel drivers...
> 
> thanks,
> 
> greg k-h
> 
Yes I'm not particularly happy about this one either. I will make this
more robust if the blacklisting idea is sound.
