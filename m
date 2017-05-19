Return-Path: <SRS0=/A9m=4Z=oracle.com=dan.carpenter@kernel.org>
Return-Path: <SRS0=/A9m=4Z=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 19 May 2017 14:20:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jork Loeser <jloeser@microsoft.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, leann.ogasawara@canonical.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: Re: [PATCH 3/4] Hyper-V vPCI: Add vPCI version protocol negotiation
Message-ID: <20170519112000.4vsmlc545mgbndqf@mwanda>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
 <1495134870-18225-4-git-send-email-jloeser@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495134870-18225-4-git-send-email-jloeser@linuxonhyperv.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 12:14:29PM -0700, Jork Loeser wrote:
>  static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  {
> +	size_t i;

Could you just use "int i".  I know some static checkers complain but
those tools are dumb.  I just fixed a couple bugs two days ago where
people were like, "If i is declared as a u32 that means it's safe" and
it turns out, nope.  No need to get fancy.

And could you put the i at the end of the declaration block in reverse
Christmas tree order?  It matches the others in this function.

	loooooooooooooooooooooooooooong var;
	meeeeeeedium var;
	int ret;
	int i;

>  	struct pci_version_request *version_req;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> @@ -1816,28 +1832,44 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  	pkt->compl_ctxt = &comp_pkt;
>  	version_req = (struct pci_version_request *)&pkt->message;
>  	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
> -	version_req->protocol_version = PCI_PROTOCOL_VERSION_CURRENT;
>  
> -	ret = vmbus_sendpacket(hdev->channel, version_req,
> -			       sizeof(struct pci_version_request),
> -			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
> -			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> -	if (ret)
> -		goto exit;
> +	for (i = 0; i < ARRAY_SIZE(pci_protocol_versions); i++) {
> +		version_req->protocol_version = pci_protocol_versions[i];
> +		ret = vmbus_sendpacket(
> +			hdev->channel, version_req,
> +			sizeof(struct pci_version_request),
> +			(unsigned long)pkt, VM_PKT_DATA_INBAND,
> +			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);

The indenting is messed up because VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
is really long.  http://new_words.enacademic.com/2023/noun-banging
NOUN_NOUN_NOUN_NOUN_NOUN_ADJECTIVE.  I guess do this:

		ret = vmbus_sendpacket(hdev->channel, version_req,
				sizeof(*version_req), (unsigned long)pkt,
				VM_PKT_DATA_INBAND,
				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);

> +		if (ret)
> +			goto exit;

This "goto exit;" prints a successful message, but it's a failure path.
We also print a message on every iteration through this function.  Since
we only go through the function once in the current code it's works but
let's fix it.

regards,
dan carpenter
