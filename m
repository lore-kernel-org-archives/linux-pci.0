Return-Path: <SRS0=NIwU=3U=mellanox.com=bodong@kernel.org>
Return-Path: <SRS0=NIwU=3U=mellanox.com=bodong@kernel.org>
Subject: Re: [v2] PCI: Add an option to control probing of VFs before enabling
 SR-IOV
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1490198038-20465-1-git-send-email-bodong@mellanox.com>
 <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <saeedm@mellanox.com>, Eli Cohen
	<eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <11a16b75-8f70-1135-a326-52fb6f31cebc@mellanox.com>
Date: Wed, 12 Apr 2017 09:34:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/alternative;
	boundary="------------7234A01147A573C03289C811"
List-ID: <linux-pci.vger.kernel.org>

--------------7234A01147A573C03289C811
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/2017 4:12 PM, Bjorn Helgaas wrote:
> Hi Bodong,
>
> On Wed, Mar 22, 2017 at 05:53:58PM +0200, bodong@mellanox.com wrote:
>> From: Bodong Wang <bodong@mellanox.com>
>>
>> Sometimes it is not desirable to probe the virtual functions after
>> SRIOV is enabled. This can save host side resource usage by VF
>> instances which would be eventually probed to VMs.
>>
>> Add a new PCI sysfs interface "sriov_probe_vfs" to control that
>> from the PF, all current callers still retain the same functionality.
>> To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>>
>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
> Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe,
> but limited to a specific PF?  I.e., could we accomplish the same thing
> with the following?
>
>    # echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>    # echo 0 > /sys/bus/pci/drivers_autoprobe
>    # echo 2 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>    # echo 1 > /sys/bus/pci/drivers_autoprobe
>
> If not, can you contrast the above with drivers_autoprobe?  If we need
> both, should they be named more similarly?
Hi Bjorn,

I agree with Alex about not using driver_autoprobe to achieve this. It 
will affect all pci related device once it's disabled(probably in a bad 
way). On the other hand, current pci driver doesn't work for this use 
case at all. VFs drivers(if any) will be probed once sriov is enabled no 
matter what. The code path is /pci_enable_sriov//-> 
//pci_bus_add_device->device_attach/, and drivers will be probed at the 
end. Drivers_autoprobe only prevents probing /pci_device_add /is 
called/. /This patch bounded the change to the device itself and 
requires no device driver update.

For the name convention, it's aligned with other sriov related sysfs 
entries. Let me know if you have better options.

Thanks,

Bodong

--------------7234A01147A573C03289C811
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 4/11/2017 4:12 PM, Bjorn Helgaas
      wrote:<br>
    </div>
    <blockquote
      cite="mid:20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com"
      type="cite">
      <pre wrap="">Hi Bodong,

On Wed, Mar 22, 2017 at 05:53:58PM +0200, <a class="moz-txt-link-abbreviated" href="mailto:bodong@mellanox.com">bodong@mellanox.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">From: Bodong Wang <a class="moz-txt-link-rfc2396E" href="mailto:bodong@mellanox.com">&lt;bodong@mellanox.com&gt;</a>

Sometimes it is not desirable to probe the virtual functions after
SRIOV is enabled. This can save host side resource usage by VF
instances which would be eventually probed to VMs.

Add a new PCI sysfs interface "sriov_probe_vfs" to control that
from the PF, all current callers still retain the same functionality.
To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to

/sys/bus/pci/devices/&lt;DOMAIN:BUS:DEVICE.FUNCTION&gt;/sriov_probe_vfs
</pre>
      </blockquote>
      <pre wrap="">
Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe, 
but limited to a specific PF?  I.e., could we accomplish the same thing
with the following?

  # echo 0 &gt; /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
  # echo 0 &gt; /sys/bus/pci/drivers_autoprobe
  # echo 2 &gt; /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
  # echo 1 &gt; /sys/bus/pci/drivers_autoprobe

If not, can you contrast the above with drivers_autoprobe?  If we need
both, should they be named more similarly?
</pre>
    </blockquote>
    Hi Bjorn,<br>
    <br>
    I agree with Alex about not using driver_autoprobe to achieve this.
    It will affect all pci related device once it's disabled(probably in
    a bad way). On the other hand, current pci driver doesn't work for
    this use case at all. VFs drivers(if any) will be probed once sriov
    is enabled no matter what. The code path is <i><span><span>pci_enable_sriov</span></span></i><i>-&gt;
    </i><span><span><i>pci_bus_add_device-&gt;device_attach</i>, and
        drivers will be probed at the end. Drivers_autoprobe only
        prevents probing <i>pci_device_add </i>is called<i>. </i>This
        patch bounded the change to the device itself and requires no
        device driver update.<br>
        <br>
        For the name convention, it's aligned with other sriov related
        sysfs entries. Let me know if you have better options.<br>
        <br>
        Thanks,<br>
        <br>
        Bodong<br>
      </span></span>
  </body>
</html>

--------------7234A01147A573C03289C811--
