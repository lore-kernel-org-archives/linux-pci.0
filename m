Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50249098.1030704@cn.fujitsu.com>
Date: Fri, 10 Aug 2012 12:39:52 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@huawei.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Wen Congyang <wency@cn.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Tony Luck <tony.luck@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <liuj97@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RFC PATCH v2 10/16] ACPIHP: system device hotplug driver skeleton
References: <1344082443-4608-1-git-send-email-jiang.liu@huawei.com> <1344082443-4608-11-git-send-email-jiang.liu@huawei.com> <502362E3.8010901@cn.fujitsu.com> <50236978.70208@huawei.com> <502377C0.70401@cn.fujitsu.com> <50238496.1000504@huawei.com>
In-Reply-To: <50238496.1000504@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/09/2012 05:36 PM, Jiang Liu wrote:
>> And I just tried it some more times. It just hung up, but dmesg had no output.
>> Like this:
>>
>> # modprobe acpihp_enum
>> (OK, and sysfs interfaces have been created)
>> # modprobe acpihp_drv
>> (hang up)
>>
>> # dmesg
>> (nothing)
>>
>> The "modprobe acpihp_drv" process's call trace shows that it hung at the following function:
>> #0  0x00000032836aab80 in __nanosleep_nocancel () from /lib64/libc.so.6
>> #1  0x00000032836deb64 in usleep () from /lib64/libc.so.6
>> ......
>>
>> I have tried several times and I cannot reproduce the situation I just said.
> You can reproduce it by loading acpihp_drv without acpihp_enum driver, I guess.
> The acpihp_drv module_init() should call acpihp_register_class() to initialize the core.
> 
Hi~

True. Thanks for your comments. :)
Since I'm new in PCI related area, if you don't mind, would you please give me some more advice about the following problem ?
Thanks. :)

"modprobe acpihp_drv" command failed, but acpihp_drv was loaded successfully, and always in use.
It cannot be removed. Is it a problem ?

[root@DP tangchen]# lsmod | grep acpi
acpi_cpufreq            9542  0 
freq_table              5030  2 cpufreq_ondemand,acpi_cpufreq
mperf                   1391  1 acpi_cpufreq
acpi_memhotplug         4414  0 

[root@DP tangchen]# modprobe acpihp_drv
Killed								(NOTE: The NULL pointer problem happened here.)

[root@DP tangchen]# echo $?
137

[root@DP tangchen]# lsmod | grep acpi
acpihp_drv             24925  1 				(NOTE: Here, the module is loaded.)
acpi_cpufreq            9542  0 
freq_table              5030  2 cpufreq_ondemand,acpi_cpufreq
mperf                   1391  1 acpi_cpufreq
acpi_memhotplug         4414  0 

[root@DP tangchen]# rmmod acpihp_drv
ERROR: Module acpihp_drv is in use


The core.c file has been compiled into kernel because of my configuration "CONFIG_ACPI_HOTPLUG=y".
As my colleague said, in this case, there is no dependency between acpihp_enum and acpihp_drv.
So I think, do we need to compile core.c into acpihp_enum module, or simply check if acpihp_enum 
has been loaded in acpihp_drv_init() ?
I am not sure if it is a good idea to move acpihp_slot_class definition and all related API to 
acpihp_enum module.

Thanks again for your comments and patient. :)


-- 
Best Regards,
Tang chen
