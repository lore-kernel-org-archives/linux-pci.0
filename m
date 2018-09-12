Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeILRaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 13:30:46 -0400
Date: Wed, 12 Sep 2018 07:26:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wesley.Sheng@microchip.com
Cc: kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver
 and misc updates
Message-ID: <20180912122625.GF118330@bhelgaas-glaptop.roam.corp.google.com>
References: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
 <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 08:55:18AM +0000, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <Wesley.Sheng@microchip.com>
> 
> 1.add pre-requisites for NTB driver
> 2.misc updates
>   change ntb hardware driver name to ntb_hw_switchtec

s/ ntb / NTB /

>   update the description of 2 partitions limit
>   add reference to Linux Documentation/ntb.txt
>   add use of term 'Command ID'
>   add use of term 'Command Return Value'
>   add a missing ')'
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>

I assume Kurt or Logan will take care of this.

> ---
>  Documentation/switchtec.txt | 30 ++++++++++++++--------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt index f788264..40e839d 100644
> --- a/Documentation/switchtec.txt
> +++ b/Documentation/switchtec.txt
> @@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec management firmware is  through the Memory-mapped Remote Procedure Call (MRPC) interface.
>  Commands are submitted to the interface with a 4-byte command  identifier and up to 1KB of command specific data. The firmware will -respond with a 4 bytes return code and up to 1KB of command specific
> +respond with a 4-byte return code and up to 1KB of command specific

This hunk looks malformed ("-" buried in middle of line above).
"Patch" complained that this patch was corrupted.

>  data. The interface only processes a single command at a time.
>  
>  
> @@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint in the system.
>  The char device has the following semantics:
>  
>  * A write must consist of at least 4 bytes and no more than 1028 bytes.
> -  The first four bytes will be interpreted as the command to run and
> -  the remainder will be used as the input data. A write will send the
> +  The first 4 bytes will be interpreted as the Command ID and the  
> + remainder will be used as the input data. A write will send the

Looks like whitespace at beginning of line is wrong here.

>    command to the firmware to begin processing.
>  
>  * Each write must be followed by exactly one read. Any double write will @@ -45,9 +45,9 @@ The char device has the following semantics:
>    produce an error.
>  
>  * A read will block until the firmware completes the command and return
> -  the four bytes of status plus up to 1024 bytes of output data. (The
> -  length will be specified by the size parameter of the read call --
> -  reading less than 4 bytes will produce an error.
> +  the 4-byte Command Return Value plus up to 1024 bytes of output  
> + data. (The length will be specified by the size parameter of the read  
> + call -- reading less than 4 bytes will produce an error.)

Also here.

>  * The poll call will also be supported for userspace applications that
>    need to do other things while waiting for the command to complete.
> @@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
>  Non-Transparent Bridge (NTB) Driver
>  ===================================
>  
> -An NTB driver is provided for the switchtec hardware in switchtec_ntb.
> -Currently, it only supports switches configured with exactly 2 -partitions. It also requires the following configuration settings:
> +An NTB hardware driver is provided for the switchtec hardware in 

"Switchtec" should be capitalized when used as a proper adjective like
this.  When used as the name of the driver, the lower-case "switchtec"
is appropriate.

> +ntb_hw_switchtec. Currently, it only supports switches configured with 
> +exactly 2 NT partitions and zero or more non-NT partitions. It also 
> +requires the following configuration settings:
>  
> -* Both partitions must be able to access each other's GAS spaces.
> +* Both NT partitions must be able to access each other's GAS spaces.
>    Thus, the bits in the GAS Access Vector under Management Settings
>    must be set to support this.
> +* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
> +  to be set)
> +
> +NT EP BAR 2 will be dynamically configured as a Direct Window, and the 
> +configuration file does not need to configure it explicitly.
> +
> +Please refer to Documentation/ntb.txt in Linux source tree for an 
> +overall understanding of the Linux NTB stack. ntb_hw_switchtec works as 
> +an NTB Hardware Driver in this stack.
